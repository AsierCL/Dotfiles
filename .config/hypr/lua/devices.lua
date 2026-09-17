-- PER-DEVICE POINTER SENSITIVITY (replaces scripts/MouseSettings.sh, kept as backup).
-- Design: NO subprocess detection. Calling `hyprctl` from inside the config
-- is unsafe: during `hyprctl reload` the inner query can hang and freeze the
-- whole compositor (every bind handler runs on the event loop). Instead each
-- known device carries its own sensitivity via hl.device(); Hyprland applies
-- it whenever that device is present — docking/undocking needs no events.
-- Values AND device names live in lua/machine-local.lua (tracked, synced);
-- get exact names from `hyprctl devices`. Touchpad enable itself is here too
-- (moved out of input.lua so all device handling sits in one place).

local ok, localConfig = pcall(require, "lua.machine-local")
local MACHINE = ok and type(localConfig) == "table" and localConfig or {}
local SENS_MOUSE = MACHINE.sensitivity_mouse or -0.8
local SENS_TOUCHPAD = MACHINE.sensitivity_touchpad or 0

-- External mice: fixed sensitivity each, identified by exact device name.
for _, name in ipairs(MACHINE.mice or {}) do
  hl.device({ name = name, sensitivity = SENS_MOUSE })
end

-- Built-in touchpad (absent/nil on machines without one).
if MACHINE.touchpad ~= nil and MACHINE.touchpad ~= false then
  hl.device({ name = MACHINE.touchpad, enabled = true, sensitivity = SENS_TOUCHPAD })
end
