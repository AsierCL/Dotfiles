-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- AUTOSTART (<- UserConfigs/Startup_Apps.conf + wallpaper exec-once from
-- UserDecorations.conf + MouseSettings.sh from hyprland.conf)
-- HOW TO: add hl.exec_cmd("<command>") inside the hyprland.start handler
-- below. hl.exec_cmd is ASYNC (never append `& disown`). Use hl.exec_raw
-- to skip the `sh -c` wrapper. To open an app on a specific workspace:
-- hl.exec_cmd("spotify", { workspace = "10 silent" }). For cleanup on exit,
-- listen to "hyprland.shutdown" the same way. Wiki: core/autostart.

local V = require("lua.vars")

hl.on("hyprland.start", function()
  -- D-Bus / systemd environment
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  -- Wallpaper + theme (were exec-once in UserDecorations.conf)
  hl.exec_cmd("swaybg -i " .. V.wallpaper .. " -m fill")
  hl.exec_cmd("wallust run " .. V.wallpaper)

  -- Bar / applets (nm-applet, swaync, blueman-applet were commented out)
  hl.exec_cmd("waybar")

  -- Clipboard manager
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")

  -- Idle daemon + scratchpads/zoom daemon
  hl.exec_cmd("hypridle")
  hl.exec_cmd("pypr")

  -- Mouse sensitivity script (was exec-once in hyprland.conf)
  hl.exec_cmd(V.scriptsDir .. "/MouseSettings.sh")
end)
