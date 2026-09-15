-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- STYLE: borders/gaps/decoration + animations
-- (<- UserConfigs/UserDecorations.conf + UserConfigs/UserAnimations.conf)
-- Palette (C.color0-15…) comes from lua/colors.lua = live wallust theme.
-- ── HOW TO ──────────────────────────────────────────────────────────
--   GAPS/BORDERS: tweak general.gaps_in/gaps_out/border_size below.
--   Border colors: general.col.active_border/inactive_border.
--   Opacity/dim: decoration.active_opacity/inactive_opacity/dim_*.
--   Shadow/blur: decoration.shadow.* / decoration.blur.*.
--   Grouped (tabbed) windows: group.col / group.groupbar.col.
--   Curves: hl.curve("<name>", { type = "bezier",
--     points = { {x0,y0}, {x1,y1} } }) — design at cssportal.com /
--     easings.net. Or type = "spring" with mass/stiffness/damping.
--   Animations: hl.animation({ leaf, enabled, speed (×100ms),
--     bezier = "<curve>", style }) — leaves form a tree, children inherit
--     unset values: windows(In/Out/Move), layers, fade*, border,
--     borderangle (style "loop" = constant repaint, costs battery),
--     workspaces(In/Out), … Wiki: configuring/core/animations.
-- NOTE: animation `speed` is capped at 100 by Hyprland (old .conf used 180
-- for borderangle — clamped, spins a bit faster than before).

local C = require("lua.colors")

hl.config({
  general = {
    border_size = 2,
    gaps_in = 6,
    gaps_out = 8,
    col = {
      active_border = C.color12,
      inactive_border = C.color10,
    },
  },
  decoration = {
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 1.0,
    dim_inactive = true,
    dim_strength = 0.1,
    dim_special = 0.8,
    shadow = {
      enabled = true,
      range = 3,
      render_power = 1,
      color = C.color12,
      color_inactive = C.color10,
    },
    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      ignore_opacity = true,
      new_optimizations = true,
      special = true,
      popups = true,
    },
  },
  group = {
    col = { border_active = C.color15 },
    groupbar = { col = { active = C.color0 } },
  },
  animations = { enabled = true },
})

-- Bezier curves ("Me-2" preset, credit mahaveergurjar)
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.5, 0 }, { 0.99, 0.99 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.5, -0.5 }, { 0.68, 1.5 } } })

-- animation = <leaf>, <enabled>, <speed (deciseconds)>, <curve>, <style>
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "smoothOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
-- loop style (rainbow borders) renders constantly at refresh rate: costs CPU/GPU + battery
-- NOTE: Lua caps animation speed at 100 (old .conf used 180 here)
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "smoothOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 5, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
