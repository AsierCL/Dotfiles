-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- ENVIRONMENT VARIABLES (<- UserConfigs/ENVariables.conf + 01-UserDefaults.conf)
-- HOW TO: add one line per variable — hl.env("KEY", "VALUE").
-- The commented blocks below are hardware-specific presets (multi-GPU, VM
-- software rendering, Firefox VA-API…); uncomment only what your machine
-- needs. Wiki: configuring/core/environment-variables.

hl.env("PATH", (os.getenv("HOME") or "/home/osbby") .. "/.local/bin:" .. (os.getenv("PATH") or ""))
hl.env("EDITOR", "nvim")

hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
-- NOTE: the old .conf set QT_QPA_PLATFORMTHEME twice (qt5ct, then qt6ct);
-- the last one won, so only qt6ct is kept (cleaned up during Lua migration).
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- hyprland-qt-support
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style")

-- xwayland apps scale fix
hl.env("GDK_SCALE", "1")

-- Bibata-Modern-Ice cursor (hyprcursor version required)
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-- firefox / electron
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- NVIDIA (wiki defaults, active in old config)
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

-- Optional / hardware-specific (were commented out — uncomment if needed):
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card1") -- nvidia as primary renderer (>0.45)
-- hl.env("GBM_BACKEND", "nvidia-drm")
-- hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
-- hl.env("__VK_LAYER_NV_optimus", "NVIDIA_only")
-- hl.env("WLR_DRM_NO_ATOMIC", "1")
-- hl.env("LIBGL_ALWAYS_SOFTWARE", "1") -- WARNING: may crash hyprland
-- hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
-- hl.env("MOZ_DISABLE_RDD_SANDBOX", "1") -- nvidia firefox HW accel
-- hl.env("EGL_PLATFORM", "wayland")
