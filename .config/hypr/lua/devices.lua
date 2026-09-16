-- DYNAMIC POINTER SENSITIVITY (replaces scripts/MouseSettings.sh, kept as backup).
-- External mouse present -> low sensitivity (-0.8); touchpad only -> 0.
-- Re-evaluated at startup and on monitor add/remove (docking a laptop or
-- plugging a display rides along with those events).
-- HOW TO: tune the two sensitivity values below. The mouse detection shells
-- out to `hyprctl -j devices` (local/fast, never in a keybind path); if the
-- query ever fails it safely falls back to touchpad sensitivity.
-- Touchpad on/off itself stays in lua/input.lua (hl.device).

local function hasExternalMouse()
  local handle = io.popen("hyprctl -j devices 2>/dev/null")
  if not handle then
    return false
  end
  local out = handle:read("*a")
  handle:close()
  if not out then
    return false
  end
  local miceBlock = out:match('"mice"%s*:%s*%[(.-)%]')
  if not miceBlock then
    return false
  end
  for name in miceBlock:gmatch('"name"%s*:%s*"([^"]+)"') do
    local n = name:lower()
    -- Skip virtual / keyboard-driven pointers: only real mice count.
    if not (n:find("virtual", 1, true) or n:find("consumer", 1, true) or n:find("system", 1, true) or n:find("control", 1, true) or n:find("keyboard", 1, true)) then
      return true
    end
  end
  return false
end

local function applyPointerSensitivity()
  if hasExternalMouse() then
    hl.config({ input = { sensitivity = -0.8 } })
  else
    hl.config({ input = { sensitivity = 0 } })
  end
end

hl.on("hyprland.start", applyPointerSensitivity)
hl.on("monitor.added", applyPointerSensitivity)
hl.on("monitor.removed", applyPointerSensitivity)
