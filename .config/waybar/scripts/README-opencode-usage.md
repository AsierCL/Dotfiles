# OpenCode Go usage in Waybar

Waybar reads the Rolling, Weekly, and Monthly meters from:

```text
GET https://opencode.ai/console/api/go/status
Authorization: Bearer <OpenCode Go key>
x-org-id: wrk_...
```

The key is resolved in this order:

1. `OPENCODE_API_KEY`, if it is set in Waybar's environment.
2. The active OpenCode Go credential saved by `/connect`, read with
   `opencode auth export`.

The module does not write, print, or store the key. The workspace ID is set in
the script and can be overridden with `OPENCODE_CONSOLE_ORG_ID`.

The Console endpoint is not part of OpenCode's documented public API. If Console
changes its session or workspace requirements, update the script accordingly.
