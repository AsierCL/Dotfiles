-- DYNAMIC PALETTE (wallust) tied to the wallpaper path in lua/vars.lua.
-- FLOW: edit the `wallpaper` path in vars.lua by hand -> `hyprctl reload` ->
--   this module 1) runs `wallust run <new>` at parse time (regenerates the
--   cache, no Wayland needed), 2) (re)launches swaybg on the image via a
--   hyprland.start handler (deferred: the Wayland socket may not exist yet
--   at parse time), 3) parses the fresh kitty cache
--   (~/.cache/wallust/colors-kitty.conf, plain `name #hex` lines) into the
--   C.background/foreground/color0-15 table used by style.lua. Same as the
--   old .conf behaviour, but driven by the path edit instead of rofi.
--   (Hyprland accepts #hex colors directly, so no conversion is needed.)
-- A marker file (~/.cache/hypr-wallpaper.applied) records the last themed
-- path, so reloads WITHOUT a path change (and --verify-config runs) only
-- re-read the cache and touch nothing.
-- Defaults below mirror hypr/wallust/wallust-hyprland.conf (template).

local V = require("lua.vars")

local M = {
  background = "rgb(000004)",
  foreground = "rgb(F8F9FB)",
  color0 = "rgb(000004)",
  color1 = "rgb(21262E)",
  color2 = "rgb(8F494F)",
  color3 = "rgb(777070)",
  color4 = "rgb(777070)",
  color5 = "rgb(B09868)",
  color6 = "rgb(B1B3B7)",
  color7 = "rgb(EDEFF1)",
  color8 = "rgb(A6A7A9)",
  color9 = "rgb(2C323D)",
  color10 = "rgb(BF616A)",
  color11 = "rgb(9F9595)",
  color12 = "rgb(9F9595)",
  color13 = "rgb(EBCB8B)",
  color14 = "rgb(ECEFF4)",
  color15 = "rgb(EDEFF1)",
}

local HOME = V.home
local kittyCache = HOME .. "/.cache/wallust/colors-kitty.conf"
local markerFile = HOME .. "/.cache/hypr-wallpaper.applied"

local function readMarker()
  local f = io.open(markerFile, "r")
  if not f then
    return nil
  end
  local last = f:read("*l")
  f:close()
  return last
end

local function shQuote(path)
  return "'" .. path:gsub("'", "'\\''") .. "'"
end

-- Theme refresh (no Wayland needed, safe at config-parse time): when the
-- path changed, regenerate wallust caches and record the marker.
if readMarker() ~= V.wallpaper then
  os.execute("wallust run " .. shQuote(V.wallpaper) .. " >/dev/null 2>&1")
  local f = io.open(markerFile, "w")
  if f then
    f:write(V.wallpaper)
    f:close()
  end
end

-- Wallpaper backend (needs the compositor UP, so it must NOT run at
-- config-parse time: the Wayland socket may not exist yet and swaybg would
-- exit immediately — black background after reboot). Launched on every
-- login via the hyprland.start event instead (hl.exec_cmd is async).
hl.on("hyprland.start", function()
  hl.exec_cmd("pkill swaybg 2>/dev/null; swaybg -i " .. shQuote(V.wallpaper) .. " -m fill")
end)

-- Overlay (fresh or previous) wallust values onto the defaults.
-- Kitty cache format is one `name value` pair per line, e.g. `color12 #9F9595`.
local f = io.open(kittyCache, "r")
if f then
  for line in f:lines() do
    local name, value = line:match("^(%S+)%s+(#%x+)%s*$")
    if name and value and M[name] ~= nil then
      M[name] = value
    end
  end
  f:close()
end

return M
