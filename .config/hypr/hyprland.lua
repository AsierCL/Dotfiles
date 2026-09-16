-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- Hyprland Lua entry point (replaces the old hyprland.conf `source=` chain).
-- Migrated from hyprlang (.conf) on v0.56.2. The old .conf files are archived
-- in hypr/legacy-hyprlang/; to roll back, move hyprland.conf back to hypr/
-- and restart Hyprland (or `hyprctl reload full-reset` after restoring it).
--
-- ── MODULE MAP ──────────────────────────────────────────────────────
--   lua/vars.lua       shared constants (terminal, dirs, touchpad name)
--   lua/env.lua        environment variables (toolkit backends, NVIDIA…)
--   lua/monitors.lua   monitor layout (resolutions, positions, scale)
--   lua/workspaces.lua workspace -> monitor assignment
--   lua/style.lua      borders/gaps/decoration/wallust colors + animations
--   lua/input.lua      keyboard/mouse/touchpad, layouts, misc, cursor…
--   lua/devices.lua    dynamic pointer sensitivity on dock/undock
--   lua/rules.lua      window + layer rules (tags, float, opacity…)
--   lua/binds.lua      ALL keybinds, incl. laptop Fn keys
--   lua/gestures.lua   trackpad gestures (>= 0.51 syntax)
--   lua/startup.lua    autostart apps on compositor start
-- ─────────────────────────────────────────────────────────────────────
-- HOW TO:
--   · Disable a module temporarily: comment its require line, then
--     `hyprctl reload` (each require is an isolated scope, so one broken
--     file never kills the others).
--   · Add a new module: create lua/mything.lua and add require("lua.mything")
--     below. Paths are relative to ~/.config/hypr; prefer dots over slashes.
-- VERIFY (without breaking your session):
--   Hyprland --verify-config --config ~/.config/hypr/hyprland.lua
--   start-hyprland -- --config ~/.config/hypr/hyprland.lua   (from a TTY)
-- DOCS: local wiki in ~/.config/hyprland-wiki + /usr/share/hypr/stubs (LSP).

require("lua.vars") -- shared constants (no side effects)
require("lua.env") -- environment variables
require("lua.monitors") -- monitor layout (+ laptop placeholder)
require("lua.workspaces") -- workspace -> monitor assignment
require("lua.style") -- borders/gaps/decoration/colors + animations
require("lua.input") -- layouts/input/misc/binds-opts/cursor + touchpad device
require("lua.devices") -- dynamic sensitivity (external mouse vs touchpad)
require("lua.rules") -- window + layer rules
require("lua.binds") -- all keybinds (incl. laptop keys)
require("lua.gestures") -- trackpad gestures (>= 0.51 syntax)
require("lua.startup") -- autostart on hyprland.start
