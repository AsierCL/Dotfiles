-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- SHARED CONSTANTS — edit values HERE, every module picks them up.
-- Replaces the $mainMod/$term/$scriptsDir/… variables that used to be
-- re-declared (and drift apart) in each old .conf file.
-- HOW TO: change `term`, `files`, `browser` below to swap your defaults
-- everywhere at once. Touchpad name comes from `hyprctl devices`.
-- Paths are relative to ~/.config/hypr (location of hyprland.lua).

local HOME = os.getenv("HOME") or "/home/osbby"

local M = {
  home = HOME,
  mainMod = "SUPER",
  term = "kitty",
  files = "nautilus",
  browser = "zen-browser",
  editor = "nvim",
}

M.hyprDir = HOME .. "/.config/hypr"
M.scriptsDir = M.hyprDir .. "/scripts"
M.userScripts = M.hyprDir .. "/UserScripts"
M.userConfigs = M.hyprDir .. "/UserConfigs" -- legacy .conf dir (kept as backup)
M.wallpaper = HOME .. "/.config/wallpapers/panda.png"
M.touchpadDevice = "asue1209:00-04f3:319f-touchpad"

return M
