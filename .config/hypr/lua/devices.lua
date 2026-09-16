-- DYNAMIC POINTER SENSITIVITY (replaces scripts/MouseSettings.sh, kept as backup).
-- External mouse present -> mouse sensitivity; touchpad only -> touchpad sensitivity.
-- Values come from lua/machine-local.lua (tracked, synced across machines); tune
-- them there. Re-evaluated at startup and on monitor add/remove (docking a laptop
-- or plugging a display rides along with those events).
-- The mouse detection shells out to `hyprctl -j devices` (local/fast, never in
-- a keybind path); if the query ever fails it safely falls back to touchpad.
-- Touchpad on/off itself stays in lua/input.lua (hl.device).

local ok, localConfig = pcall(require, "lua.machine-local")
local MACHINE = ok and type(localConfig) == "table" and localConfig or {}
local SENS_MOUSE = MACHINE.sensitivity_mouse or -0.8
local SENS_TOUCHPAD = MACHINE.sensitivity_touchpad or 0

local function stripHlSuffix(name)
  -- Hyprland appends -mouse/-touchpad/-keyboard/... to the libinput base name.
  for _, suffix in ipairs({ "-touchpad", "-mouse", "-keyboard", "-gesture" }) do
    if #name > #suffix and name:sub(-#suffix) == suffix then
      return name:sub(1, -#suffix - 1)
    end
  end
  return name
end

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
  -- A built-in trackpad registers BOTH as a "-touchpad" and a "-mouse" node
  -- (same libinput base). Build the set of trackpad bases so the paired
  -- "-mouse" device is not mistaken for an external mouse.
  local touchpadBases = {}
  for name in miceBlock:gmatch('"name"%s*:%s*"([^"]+)"') do
    local uname = name:lower()
    if uname:find("touchpad", 1, true) or uname:find("trackpad", 1, true) or uname:find("glidepoint", 1, true) or uname:find("synaptics", 1, true) then
      touchpadBases[stripHlSuffix(name)] = true
    end
  end
  for name in miceBlock:gmatch('"name"%s*:%s*"([^"]+)"') do
    local n = name:lower()
    -- Skip virtual / keyboard-driven pointers and built-in trackpads (incl.
    -- their "-mouse" sibling): only real external mice count.
    if not (n:find("virtual", 1, true) or n:find("consumer", 1, true) or n:find("system", 1, true) or n:find("control", 1, true) or n:find("keyboard", 1, true) or touchpadBases[stripHlSuffix(name)]) then
      return true
    end
  end
  return false
end

local function applyPointerSensitivity()
  if hasExternalMouse() then
    hl.config({ input = { sensitivity = SENS_MOUSE } })
  else
    hl.config({ input = { sensitivity = SENS_TOUCHPAD } })
  end
end

hl.on("hyprland.start", applyPointerSensitivity)
hl.on("monitor.added", applyPointerSensitivity)
hl.on("monitor.removed", applyPointerSensitivity)
