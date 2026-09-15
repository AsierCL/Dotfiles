-- WALLUST PALETTE — dynamic theme colors shared by style.lua.
-- The old hyprlang setup did `source ~/.cache/wallust/colors-hyprland.conf`
-- which defined $background/$foreground/$color0-15. Lua can't `source`
-- hyprlang, so we parse that same generated file at (re)load time instead.
-- HOW TO:
--   · Nothing to do normally: `wallust run <wallpaper>` regenerates the
--     cache file, then `hyprctl reload` applies it here + in style.lua.
--   · To freeze a static palette (ignore wallust), just edit the fallback
--     values below and delete/rename the cache file.
-- Fallback values mirror hypr/wallust/wallust-hyprland.conf (template).

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

-- Overlay live values from wallust's generated hyprlang file, if present.
-- NOTE: this runs at (re)load time only; after `wallust run` re-generate,
-- run `hyprctl reload` so the new palette is picked up.
local cachePath = (os.getenv("HOME") or "/home/osbby") .. "/.cache/wallust/colors-hyprland.conf"
local f = io.open(cachePath, "r")
if f then
  for line in f:lines() do
    local name, value = line:match("^%$(%w+)%s*=%s*(.-)%s*$")
    if name and value and M[name] ~= nil then
      M[name] = value
    end
  end
  f:close()
end

return M
