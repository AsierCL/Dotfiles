#!/usr/bin/env python3
"""Show OpenCode Go rolling, weekly, and monthly usage in Waybar.

The credential comes from OPENCODE_API_KEY or from the OpenCode Go key saved by
/connect. It is never written by this module or included in its output.
"""

from __future__ import annotations

import html
import json
import os
import re
import shutil
import subprocess
import sys
import urllib.error
import urllib.request
from datetime import datetime, timezone
from typing import Any


CONSOLE = "https://opencode.ai"
STATUS_PATH = "/console/api/go/status"
DEFAULT_ORG_ID = "wrk_01M28ETJK5TWZ7RX45YX9Q9D3E"
USER_AGENT = "waybar-opencode-usage/1.0"
REQUEST_TIMEOUT = 8


class UsageError(Exception):
    """An expected error while obtaining Console usage."""


def emit(text: str, tooltip: str) -> None:
    print(json.dumps({"text": text, "tooltip": tooltip}))


def env_api_key() -> str | None:
    key = os.environ.get("OPENCODE_API_KEY", "").strip()
    return key or None


def key_from_opencode_auth() -> str:
    binary = shutil.which("opencode")
    if not binary:
        raise UsageError("No se encontró el comando opencode para leer la clave de /connect.")

    try:
        result = subprocess.run(
            [binary, "auth", "export"],
            check=False,
            capture_output=True,
            text=True,
            timeout=REQUEST_TIMEOUT,
        )
    except (OSError, subprocess.TimeoutExpired) as exc:
        raise UsageError("No se pudo leer la credencial guardada por /connect.") from exc

    if result.returncode != 0:
        raise UsageError("opencode auth export falló al leer la credencial de /connect.")

    try:
        records = json.loads(result.stdout)
    except json.JSONDecodeError as exc:
        raise UsageError("No se pudo interpretar la credencial guardada por /connect.") from exc

    candidates = [
        record
        for record in records
        if isinstance(record, dict)
        and record.get("integrationID") == "opencode-go"
        and isinstance(record.get("value"), dict)
        and isinstance(record["value"].get("key"), str)
        and record["value"]["key"].strip()
    ]
    active = [record for record in candidates if record.get("active")]
    for record in active + candidates:
        return record["value"]["key"].strip()

    raise UsageError("No hay una clave de OpenCode Go guardada por /connect.")


def credentials() -> tuple[str, str]:
    key = env_api_key() or key_from_opencode_auth()

    org_id = os.environ.get("OPENCODE_CONSOLE_ORG_ID", "").strip() or DEFAULT_ORG_ID
    if not re.fullmatch(r"[A-Za-z0-9_-]{1,128}", org_id):
        raise UsageError("OPENCODE_CONSOLE_ORG_ID no tiene un formato válido (wrk_...).")
    return key, org_id


def get_usage(key: str, org_id: str) -> dict[str, Any]:
    request = urllib.request.Request(
        CONSOLE + STATUS_PATH,
        headers={
            "Accept": "application/json",
            "Authorization": f"Bearer {key}",
            "User-Agent": USER_AGENT,
            "x-org-id": org_id,
        },
        method="GET",
    )

    try:
        with urllib.request.urlopen(request, timeout=REQUEST_TIMEOUT) as response:
            payload = json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as exc:
        if exc.code == 403:
            try:
                error = json.loads(exc.read().decode("utf-8"))
            except (UnicodeDecodeError, json.JSONDecodeError):
                error = {}
            if error.get("error_code") == 1010 or error.get("error_name") == "browser_signature_banned":
                raise UsageError(
                    "Cloudflare bloqueó la consulta desde Waybar (Error 1010)."
                ) from exc
        if exc.code in (401, 403):
            raise UsageError(
                "Console rechazó la clave de OpenCode Go. Vuelve a conectarla con /connect."
            ) from exc
        if exc.code == 400:
            raise UsageError("Console no reconoce el workspace indicado.")
        raise UsageError(f"Console respondió HTTP {exc.code}.") from exc
    except (urllib.error.URLError, TimeoutError, OSError) as exc:
        raise UsageError("No se pudo conectar con OpenCode Console.") from exc
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise UsageError("Console devolvió una respuesta no válida.") from exc

    if not isinstance(payload, dict):
        raise UsageError("Console devolvió una respuesta no válida.")
    return payload


def as_number(value: Any) -> float | None:
    if isinstance(value, (int, float)):
        return float(value)
    if isinstance(value, str) and value.strip():
        try:
            return float(value)
        except ValueError:
            return None
    return None


def as_datetime(value: Any) -> datetime | None:
    number = as_number(value)
    if number is not None:
        timestamp = number / 1000 if number > 10_000_000_000 else number
        try:
            return datetime.fromtimestamp(timestamp, tz=timezone.utc)
        except (OverflowError, OSError, ValueError):
            return None
    if not isinstance(value, str):
        return None
    try:
        parsed = datetime.fromisoformat(value.replace("Z", "+00:00"))
        return parsed.replace(tzinfo=timezone.utc) if parsed.tzinfo is None else parsed
    except ValueError:
        return None


def countdown(value: Any) -> str:
    resets_at = as_datetime(value)
    if resets_at is None:
        return "no disponible"

    seconds = max(0, int((resets_at - datetime.now(timezone.utc)).total_seconds()))
    hours, remainder = divmod(seconds, 3600)
    minutes = remainder // 60
    if hours >= 24:
        days, hours = divmod(hours, 24)
        return f"{days}d {hours}h"
    return f"{hours}h {minutes}m"


def meter_percent(meter: Any) -> tuple[int, str]:
    if not isinstance(meter, dict):
        raise UsageError("Falta información de una ventana de uso.")

    used = as_number(meter.get("usedMicroCents"))
    limit = as_number(meter.get("limitMicroCents"))
    if used is None or limit is None:
        raise UsageError("Console devolvió límites de uso no válidos.")

    percent = 0 if limit <= 0 else min(100, max(0, round(used / limit * 100)))
    return percent, countdown(meter.get("resetsAt"))


def main() -> int:
    try:
        key, org_id = credentials()
        status = get_usage(key, org_id)
        access = status.get("access")
        meters = access.get("meters") if isinstance(access, dict) else None
        if not isinstance(meters, dict):
            raise UsageError("No se encontraron los límites de OpenCode Go.")

        definitions = (
            ("fiveHour", "Rolling", "R"),
            ("week", "Weekly", "W"),
            ("month", "Monthly", "M"),
        )
        details: list[str] = []
        compact: list[str] = []
        for key_name, label, short in definitions:
            percent, reset = meter_percent(meters.get(key_name))
            compact.append(f"{short} {percent}%")
            details.append(f"{label}: {percent}% usado · reinicia en {reset}")

        emit("  ".join(compact), "OpenCode Go\n" + "\n".join(details))
        return 0
    except UsageError as exc:
        emit("Go —", "OpenCode Go\n" + html.escape(str(exc)))
        return 0


if __name__ == "__main__":
    sys.exit(main())
