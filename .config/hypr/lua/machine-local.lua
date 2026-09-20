-- Pointer tuning shared by all machines (tracked in the repo).
-- lua/devices.lua gives sensitivity_mouse to every name in `mice` and
-- sensitivity_touchpad to `touchpad`. Entries for absent devices are harmless,
-- so list EVERY machine's hardware here: no hostname branching needed.
-- Unknown devices fall back to input.sensitivity (see lua/input.lua).
-- Exact names come from `hyprctl devices`.
return {
  sensitivity_mouse = -0.8,
  sensitivity_touchpad = 0,
  mice = {
    "2.4g-dongle-1", -- desktop 2.4GHz dongle
    "e-signal-kult-nitrogen-neutron", -- desktop E-Signal
    -- NOTE(laptop): append this machine's external mouse names here.
  },
  -- Laptop built-in trackpad (<- old Laptops.conf $Touchpad_Device).
  -- Harmless on the desktop (device simply never appears there).
  touchpad = "elan0718:00-04f3:30fd-touchpad",
}
