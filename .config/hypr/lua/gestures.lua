-- /* Native Hyprland trackpad gestures (>= 0.51 syntax) */ --
-- (<- UserConfigs/LaptopGestures.conf)
-- ── HOW TO ──────────────────────────────────────────────────────────
--   hl.gesture({ fingers = 3|4, direction = "…", action = "…", mods?, … })
--   Directions: horizontal | vertical | left | right | up | down |
--     swipe | pinch | pinchin | pinchout.
--   Actions: workspace | close | fullscreen (mode="maximize" for maximize) |
--     float (mode="float"|"tile") | special + workspace_name="…" |
--     cursor_zoom + zoom_level | move | resize | scroll_move | "unset"
--     (unset disables a gesture but must match fingers/direction/mods/scale
--     exactly) — or a Lua function / { start, update, finish } live table.
--   Old `gesture = N, dir, mod: KEY, dispatcher, <hyprlang args>` becomes a
--   lambda calling hl.dispatch(...) as shown in the modifier examples below.
--   Wiki: configuring/core/binds/gestures.

-- 3-finger horizontal swipe -> switch workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- 3-finger vertical -> window control
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "down", action = "close" })

-- 4-finger layout management
hl.gesture({ fingers = 4, direction = "left", action = "float" })
hl.gesture({ fingers = 4, direction = "pinchin", action = "special", workspace_name = "overview" })
hl.gesture({ fingers = 4, direction = "pinchout", action = "fullscreen" })

-- Gestures with modifiers (old `dispatcher, movetoworkspace ...`)
hl.gesture({
  fingers = 3,
  direction = "up",
  mods = "SUPER",
  action = function()
    hl.dispatch(hl.dsp.window.move({ workspace = "1" }))
  end,
})
hl.gesture({
  fingers = 3,
  direction = "left",
  mods = "ALT",
  action = function()
    hl.dispatch(hl.dsp.window.move({ workspace = "r-1" }))
  end,
})

-- To disable a bothersome gesture (must match fingers/direction/mods/scale exactly):
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "unset" })
