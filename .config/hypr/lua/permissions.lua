-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- PERMISSIONS: persistent allow-list for Hyprland's built-in permission
-- system (<- required by hyprland.lua; ecosystem.enforce_permissions = true
-- lives in lua/input.lua).
-- HOW TO: hl.permission({ binary = "<regex>", type = "<type>", mode = "<mode>" })
--   binary: regex matched against the client binary path.
--   type: "screencopy" (grim/portal/OBS/Discord screen capture),
--     "plugin" (hyprpm), "keyboard" (new keyboards).
--   mode: "allow" (silent) | "ask" (popup each time) | "deny" (always block).
-- NOTE: changes here require a full Hyprland RESTART, `hyprctl reload` is
-- not enough. Wiki: configuring/advanced-and-cool/permissions.

-- Captura de pantalla de los dotfiles: scripts/ScreenShot.sh usa
-- grim + slurp (+ swappy para anotar). grim es quien hace screencopy.
hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/slurp", type = "screencopy", mode = "allow" })

-- Portal de escritorio (Discord/OBS/navegadores comparten vía portal).
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })

-- Pantalla de bloqueo.
hl.permission({ binary = "/usr/(bin|local/bin)/hyprlock", type = "screencopy", mode = "allow" })

-- Discord (screen-share / streaming).
hl.permission({ binary = "/usr/(bin|local/bin)/discord", type = "screencopy", mode = "allow" })

-- OBS Studio (grabación / streaming). Paquete: obs-studio (no instalado).
hl.permission({ binary = "/usr/(bin|local/bin)/obs", type = "screencopy", mode = "allow" })
