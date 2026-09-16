-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- KEYBINDS (<- configs/Keybinds.conf + UserConfigs/UserKeybinds.conf + laptop
-- keys from Laptops.conf). Sections below: session · focus/move/resize ·
-- workspaces · mouse · user apps · laptop Fn keys · lid switch (commented).
-- ── HOW TO ADD A BIND ───────────────────────────────────────────────
--   hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("firefox"))
--   hl.bind("SUPER + X", function()                       -- custom logic:
--     hl.dispatch(hl.dsp.window.float())                  -- dsp.* tables do
--   end)                                                  -- NOTHING on their
--                                                         -- own, wrap in fn.
--   Keys: "SUPER/ALT/CTRL/SHIFT + <keysym>" (+ = separator). Mouse:
--   "mouse:272" (button), "mouse_down/mouse_up" (scroll). Keycodes (layout
--   independent): "code:10". Mod-only: "Alt_L". Find names with `wev`.
--   Flags (3rd arg): { repeating = true } (hold-to-repeat, old `binde`),
--   { locked = true } (works on lock screen, old `bindl`), { mouse = true }
--   (mouse drag binds, old `bindm`), { non_consuming = true } (pass key
--   through too, old `bindn`), { description = "…" } (shows in hyprctl binds).
--   Common dispatchers: window.close/kill/float/fullscreen/center/pin,
--   focus{direction|workspace}, window.move{direction|workspace, follow=false
--   = silent}, layout("togglesplit"), exec_cmd("…"), workspace.toggle_special().
--   Unbind: hl.unbind("SUPER + Q") (case-sensitive) or handle:remove().
--   Wiki: configuring/core/binds + dispatchers. List live binds: hyprctl binds.
-- ── Old variant mapping: bind→{} · binde→repeating · bindl→locked ────
-- ── bindel→locked+repeating · bindm→mouse · bindn→non_consuming ───────

local V = require("lua.vars")
local S = V.scriptsDir
local US = V.userScripts
local M = V.mainMod -- "SUPER"

-- Session
hl.bind("CTRL + ALT + Delete", hl.dsp.exit()) -- exit Hyprland (was: hyprctl dispatch exit 0)
hl.bind(M .. " + C", hl.dsp.window.close()) -- kill active window
hl.bind(M .. " + F", hl.dsp.window.fullscreen()) -- toggle fullscreen
hl.bind(M .. " + SHIFT + F", hl.dsp.window.float()) -- toggle floating
hl.bind(M .. " + ALT + F", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat")) -- all windows floating
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd(S .. "/LockScreen.sh"))
hl.bind("CTRL + ALT + P", hl.dsp.exec_cmd(S .. "/Wlogout.sh"))

-- Dwindle layout
hl.bind(M .. " + I", hl.dsp.layout("togglesplit"))

-- Cycle floating windows and bring to top (two old binds on same key -> one lambda)
hl.bind("ALT + Tab", function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Media / special keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(S .. "/Volume.sh --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(S .. "/Volume.sh --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(S .. "/Volume.sh --toggle-mic"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(S .. "/Volume.sh --toggle"), { locked = true })
hl.bind("XF86Sleep", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
hl.bind("XF86RFKill", hl.dsp.exec_cmd(S .. "/AirplaneMode.sh"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(S .. "/MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(S .. "/MediaCtrl.sh --pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(S .. "/MediaCtrl.sh --nxt"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(S .. "/MediaCtrl.sh --prv"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd(S .. "/MediaCtrl.sh --stop"), { locked = true })

-- Screenshots (Print; laptop F6 variants further below)
hl.bind(M .. " + Print", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --now"))
hl.bind(M .. " + SHIFT + Print", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --area"))
hl.bind(M .. " + CTRL + Print", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --in5"))
hl.bind(M .. " + CTRL + SHIFT + Print", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --in10"))
hl.bind("ALT + Print", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --active"))
hl.bind(M .. " + SHIFT + S", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --swappy"))

-- Rofi emoji
hl.bind(M .. " + E", hl.dsp.exec_cmd(S .. "/RofiEmoji.sh"))

-- Clipboard history (cliphist daemon runs at startup; pick & copy back)
hl.bind(M .. " + V", hl.dsp.exec_cmd(
  "cliphist list | rofi -dmenu -config " .. V.home .. "/.config/rofi/config-clipboard.rasi | cliphist decode | wl-copy"
), { description = "Clipboard history" })

-- Keybind cheatsheet (curated list in scripts/KeyHints.sh; keep it in sync
-- when you add binds here). SUPER + ? is Shift + / on most layouts.
hl.bind(M .. " + question", hl.dsp.exec_cmd(S .. "/KeyHints.sh"), { description = "Keybind cheatsheet" })

-- Resize (repeat on hold)
hl.bind(M .. " + CTRL + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(M .. " + CTRL + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(M .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(M .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Move windows
hl.bind(M .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(M .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(M .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(M .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Move focus
hl.bind(M .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(M .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(M .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(M .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces: next/prev monitor workspace
hl.bind(M .. " + Tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(M .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))

-- Special workspace (scratchpad)
hl.bind(M .. " + SHIFT + U", hl.dsp.window.move({ workspace = "special" }))
hl.bind(M .. " + U", hl.dsp.workspace.toggle_special())

-- Workspaces 1-10 via keycodes (layout-independent, 1 = code:10 ... 0 = code:19)
for i = 0, 9 do
  local code = 10 + i
  local ws = tostring(i == 9 and 10 or (i + 1))
  hl.bind(M .. " + code:" .. code, hl.dsp.focus({ workspace = ws }))
  hl.bind(M .. " + SHIFT + code:" .. code, hl.dsp.window.move({ workspace = ws }))
  hl.bind(M .. " + CTRL + code:" .. code, hl.dsp.window.move({ workspace = ws, follow = false }))
end
hl.bind(M .. " + SHIFT + bracketleft", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(M .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(M .. " + CTRL + bracketleft", hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind(M .. " + CTRL + bracketright", hl.dsp.window.move({ workspace = "+1", follow = false }))

-- Scroll through workspaces
hl.bind(M .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(M .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(M .. " + period", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(M .. " + comma", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse drag
hl.bind(M .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(M .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ---- User keybinds (<- UserKeybinds.conf) ----
hl.bind(M .. " + D", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"))
hl.bind(M .. " + CTRL + F", hl.dsp.window.fullscreen({ mode = "maximized" })) -- fake fullscreen
hl.bind(M .. " + Return", hl.dsp.exec_cmd(V.term))
hl.bind(M .. " + T", hl.dsp.exec_cmd(V.files))
hl.bind(M .. " + B", hl.dsp.exec_cmd(V.browser))
hl.bind(M .. " + ALT + C", hl.dsp.exec_cmd(US .. "/RofiCalc.sh"))
hl.bind(M .. " + SHIFT + Return", hl.dsp.exec_cmd("pypr toggle term")) -- pypr dropdown term
hl.bind(M .. " + SHIFT + T", hl.dsp.exec_cmd("pypr toggle files")) -- pypr dropdown files (ranger, see pyprland.toml)
hl.bind(M .. " + Z", hl.dsp.exec_cmd("pypr zoom"))
hl.bind(M .. " + ALT + K", hl.dsp.exec_cmd(S .. "/SwitchKeyboardLayout.sh"), { non_consuming = true })
hl.bind(M .. " + CTRL + A", hl.dsp.exec_cmd(S .. "/SwitchSoundOutput.sh"), { description = "Switch audio output" })

-- Night light toggle (hyprsunset must be running, see startup.lua).
-- Flips between warm 4500K and neutral; the time profiles in
-- hypr/hyprsunset.conf override this at the next profile time.
local nightLight = false
hl.bind(M .. " + CTRL + S", function()
  nightLight = not nightLight
  if nightLight then
    hl.dispatch(hl.dsp.exec_cmd("hyprctl hyprsunset temperature 4500"))
  else
    hl.dispatch(hl.dsp.exec_cmd("hyprctl hyprsunset identity"))
  end
end, { description = "Night light toggle" })

-- ---- Laptop keys (<- Laptops.conf) ----
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd(S .. "/BrightnessKbd.sh --dec"), { repeating = true })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd(S .. "/BrightnessKbd.sh --inc"), { repeating = true })
hl.bind("XF86Launch1", hl.dsp.exec_cmd("rog-control-center"))
hl.bind("XF86Launch3", hl.dsp.exec_cmd("asusctl led-mode -n"))
hl.bind("XF86Launch4", hl.dsp.exec_cmd("asusctl profile -n"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(S .. "/Brightness.sh --dec"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(S .. "/Brightness.sh --inc"), { repeating = true })
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd(S .. "/TouchPad.sh"))
-- Screenshots via F6 (no Print key on laptop)
hl.bind(M .. " + F6", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --now"))
hl.bind(M .. " + SHIFT + F6", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --area"))
hl.bind(M .. " + CTRL + F6", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --in5"))
hl.bind(M .. " + ALT + F6", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --in10"))
hl.bind("ALT + F6", hl.dsp.exec_cmd(S .. "/ScreenShot.sh --active"))

-- Lid switch (were commented out — verify actual switch name with `hyprctl devices`
-- and uncomment the pair you want):
-- Disable laptop monitor when lid closes:
-- hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, preferred, auto, 1"'), { locked = true })
-- hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, disable"'), { locked = true })
