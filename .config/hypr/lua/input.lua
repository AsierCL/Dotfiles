-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- INPUT & CORE BEHAVIOUR (<- UserConfigs/UserSettings.conf; per-device
-- sensitivity/touchpad lives in lua/devices.lua; trackpad *gestures* in
-- lua/gestures.lua)
-- ── HOW TO ──────────────────────────────────────────────────────────
--   Layout engine: general.layout = "dwindle" | "master" (+ dwindle.* /
--     master.* tables above it). Per-workspace layouts go in workspaces.lua.
--   Keyboard: input.kb_layout/kb_variant/kb_options… (options list:
--     `cat /usr/share/X11/xkb/rules/base.lst`, e.g. "caps:swapescape").
--   Mouse: input.sensitivity (this setup: -0.8), accel_profile, follow_mouse.
--   Touchpad: input.touchpad.* (tap_to_click, natural_scroll…).
--   Swipe tuning: gestures.* here; swipe ACTIONS are in gestures.lua.
--   Window swallowing: misc.enable_swallow + swallow_regex (here: kitty).
--   VRR: misc.vrr (0 off … 2 fullscreen). Screenshot/vrr quirks per-window
--     go in rules.lua. Wiki: configuring/core/* (devices, config-options).

hl.config({
  dwindle = {
    preserve_split = true,
    special_scale_factor = 0.8,
  },
  master = {
    new_status = "master",
    new_on_top = 1,
    mfact = 0.5,
  },
  general = {
    resize_on_border = true,
    layout = "dwindle",
  },
  input = {
    kb_layout = "us, es",
    kb_variant = "altgr-intl",
    kb_model = "",
    kb_options = "",
    kb_rules = "",
    repeat_rate = 50,
    repeat_delay = 300,
    sensitivity = -0.8, -- mouse sensitivity
    numlock_by_default = true,
    left_handed = false,
    follow_mouse = 1, -- 0, 1, 2 or 3
    float_switch_override_focus = false,
    touchpad = {
      disable_while_typing = true,
      natural_scroll = false,
      clickfinger_behavior = false,
      middle_button_emulation = true,
      tap_to_click = true,
      drag_lock = false,
    },
    touchdevice = { enabled = true },
    tablet = { transform = 0, left_handed = 0 },
  },
  -- Legacy swipe tuning (Hyprland >= 0.51 gestures live in lua/gestures.lua)
  gestures = {
    workspace_swipe_distance = 500,
    workspace_swipe_invert = true,
    workspace_swipe_min_speed_to_force = 30,
    workspace_swipe_cancel_ratio = 0.5,
    workspace_swipe_create_new = true,
    workspace_swipe_forever = true,
    -- workspace_swipe_use_r = true, -- forever new workspace on swipe right
  },
  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    vrr = 2,
    mouse_move_enables_dpms = true,
    enable_swallow = true,
    swallow_regex = "^(kitty)$",
    focus_on_activate = false,
    initial_workspace_tracking = 0,
    middle_click_paste = false,
  },
  binds = {
    workspace_back_and_forth = true,
    allow_workspace_cycles = true,
    pass_mouse_when_bound = false,
  },
  xwayland = { enabled = true, force_zero_scaling = true },
  -- render = { explicit_sync = 2, explicit_sync_kms = 2, direct_scanout = false }, -- >= 0.42, was commented out
  cursor = {
    sync_gsettings_theme = true,
    no_hardware_cursors = true,
    enable_hyprcursor = true,
    warp_on_change_workspace = 2,
    no_warps = true,
  },
  ecosystem = {
    no_donation_nag = true, -- hide the donation notice at startup
    no_update_news = true, -- hide update news in the log
    -- Stricter permission model for plugins/IPC (wiki: advanced-configuration/permissions).
    -- Takes effect on full RESTART, not on `hyprctl reload`.
    enforce_permissions = true,
  },
})
