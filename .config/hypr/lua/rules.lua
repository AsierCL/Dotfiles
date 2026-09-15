-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- WINDOW + LAYER RULES (<- UserConfigs/WindowRules.conf + deadlocked rule)
-- Sections below: TAGS (classify windows) · POSITION · WORKSPACES · FLOAT ·
-- OPACITY · SIZE · PINNING/EXTRAS · BLUR&FULLSCREEN · LAYER RULES.
-- ── HOW TO ADD A RULE ───────────────────────────────────────────────
--   hl.window_rule({ match = { class = [[^(kitty)$]] }, float = true })
--   match props: class | title | initial_class | initial_title (match at
--   spawn time) | tag ("email*" matches email AND email*) | focus | float |
--   fullscreen | workspace | xwayland | … Values are RE2 regex; prefix with
--   `negative:` to negate. Regexes go in [[…]] so backslashes stay intact.
--   STATIC effects (applied once at open — float/center/size/move/workspace/
--   monitor/pin/…): matching on `title` only sees the INITIAL title; for
--   title changes after open use hl.on("window.title", …) + hl.dispatch.
--   DYNAMIC effects (re-evaluated live — opacity/border_color/rounding/
--   no_blur/no_shadow/tag/…): hl.window_rule({ match={…}, opacity="0.9 0.7" })
--   (values "active inactive", append " override" for absolute instead of
--   multiplied). Layer rules: hl.layer_rule({ match={namespace="rofi"}, … }).
--   Order: NAMED rules first, then anonymous; LAST match wins. Only named
--   rules (name="…") can be toggled later via handle:set_enabled(bool).
--   Wiki: configuring/core/rules/window-rules. Inspect: hyprctl clients.

-- ---------- TAG RULES ----------
-- Browsers
hl.window_rule({ match = { class = [[^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$]] }, tag = "+browser" })
hl.window_rule({ match = { class = [[^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$]] }, tag = "+browser" })
hl.window_rule({ match = { class = [[^(chrome-.+-Default)$]] }, tag = "+browser" })
hl.window_rule({ match = { class = [[^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$]] }, tag = "+browser" })
hl.window_rule({ match = { class = [[^(Brave-browser(-beta|-dev|-unstable)?)$]] }, tag = "+browser" })
hl.window_rule({ match = { class = [[^([Tt]horium-browser|[Cc]achy-browser)$]] }, tag = "+browser" })
hl.window_rule({ match = { class = [[^(zen-alpha)$]] }, tag = "+browser" })
-- Terminals
hl.window_rule({ match = { class = [[^(Alacritty|kitty|kitty-dropterm|pypr-term)$]] }, tag = "+terminal" })
-- Email
hl.window_rule({ match = { class = [[^([Tt]hunderbird|org.gnome.Evolution)$]] }, tag = "+email" })
hl.window_rule({ match = { class = [[^(eu.betterbird.Betterbird)$]] }, tag = "+email" })
-- Projects
hl.window_rule({ match = { class = [[^(codium|codium-url-handler|VSCodium)$]] }, tag = "+projects" })
hl.window_rule({ match = { class = [[^(VSCode|code-url-handler)$]] }, tag = "+projects" })
hl.window_rule({ match = { class = [[^(jetbrains-.+)$]] }, tag = "+projects" })
-- Screenshare
hl.window_rule({ match = { class = [[^(com.obsproject.Studio)$]] }, tag = "+screenshare" })
-- IM
hl.window_rule({ match = { class = [[^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$]] }, tag = "+im" })
hl.window_rule({ match = { class = [[^([Ff]erdium)$]] }, tag = "+im" })
hl.window_rule({ match = { class = [[^([Ww]hatsapp-for-linux)$]] }, tag = "+im" })
hl.window_rule({ match = { class = [[^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$]] }, tag = "+im" })
hl.window_rule({ match = { class = [[^(teams-for-linux)$]] }, tag = "+im" })
-- Games / stores
hl.window_rule({ match = { class = [[^(gamescope)$]] }, tag = "+games" })
hl.window_rule({ match = { class = [[^(steam_app_\d+)$]] }, tag = "+games" })
hl.window_rule({ match = { class = [[^([Ss]team)$]] }, tag = "+gamestore" })
hl.window_rule({ match = { title = [[^([Ll]utris)$]] }, tag = "+gamestore" })
hl.window_rule({ match = { class = [[^(com.heroicgameslauncher.hgl)$]] }, tag = "+gamestore" })
-- File managers
hl.window_rule({ match = { class = [[^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$]] }, tag = "+file-manager" })
hl.window_rule({ match = { class = [[^(app.drey.Warp)$]] }, tag = "+file-manager" })
-- Multimedia
hl.window_rule({ match = { class = [[^([Aa]udacious)$]] }, tag = "+multimedia" })
-- Settings
hl.window_rule({ match = { title = [[^(ROG Control)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^([Bb]aobab|org.gnome.[Bb]aobab)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^(gnome-disks|wihotspot(-gui)?)$]] }, tag = "+settings" })
hl.window_rule({ match = { title = [[^(Kvantum Manager)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^(file-roller|org.gnome.FileRoller)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^(nm-applet|nm-connection-editor|blueman-manager)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^(nwg-look|qt5ct|qt6ct|[Yy]ad)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^(xdg-desktop-portal-gtk)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^(org.kde.polkit-kde-authentication-agent-1)$]] }, tag = "+settings" })
hl.window_rule({ match = { class = [[^([Rr]ofi)$]] }, tag = "+settings" })
-- Viewers
hl.window_rule({ match = { class = [[^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$]] }, tag = "+viewer" })
hl.window_rule({ match = { class = [[^(evince)$]] }, tag = "+viewer" })
hl.window_rule({ match = { class = [[^(eog|org.gnome.Loupe)$]] }, tag = "+viewer" })

-- ---------- POSITION ----------
hl.window_rule({ match = { class = [[^([Tt]hunar)$]], title = [[negative:(.*[Tt]hunar.*)]] }, center = true })
hl.window_rule({ match = { title = [[^(ROG Control)$]] }, center = true })
hl.window_rule({ match = { title = [[^(Keybindings)$]] }, center = true })
hl.window_rule({ match = { class = [[^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$]] }, center = true })
hl.window_rule({ match = { class = [[^([Ww]hatsapp-for-linux)$]] }, center = true })
hl.window_rule({ match = { class = [[^([Ff]erdium)$]] }, center = true })
hl.window_rule({ match = { title = [[^(Picture-in-Picture)$]] }, move = { "72%", "7%" } })

-- ---------- WORKSPACES ----------
hl.window_rule({ match = { tag = "email*" }, workspace = "1" })
hl.window_rule({ match = { tag = "browser*" }, workspace = "2" })
hl.window_rule({ match = { tag = "gamestore*" }, workspace = "5" })
hl.window_rule({ match = { tag = "im*" }, workspace = "7" })
hl.window_rule({ match = { tag = "games*" }, workspace = "8" })
hl.window_rule({ match = { tag = "screenshare*" }, workspace = "4 silent" })
hl.window_rule({ match = { class = [[^(virt-manager)$]] }, workspace = "6 silent" })
hl.window_rule({ match = { class = [[^(.virt-manager-wrapped)$]] }, workspace = "6 silent" })
hl.window_rule({ match = { tag = "multimedia*" }, workspace = "9 silent" })
hl.window_rule({ match = { class = [[^([Ss]potify)$]] }, workspace = "10 silent" })

-- ---------- FLOAT ----------
hl.window_rule({ match = { tag = "wallpaper*" }, float = true })
hl.window_rule({ match = { tag = "settings*" }, float = true })
hl.window_rule({ match = { tag = "viewer*" }, float = true })
hl.window_rule({ match = { class = [[^([Zz]oom|onedriver|onedriver-launcher)$]] }, float = true })
hl.window_rule({ match = { class = [[^(org.gnome.Calculator)$]], title = [[^(Calculator)$]] }, float = true })
hl.window_rule({ match = { class = [[^(mpv|com.github.rafostar.Clapper)$]] }, float = true })
hl.window_rule({ match = { class = [[^([Qq]alculate-gtk)$]] }, float = true })
hl.window_rule({ match = { class = [[^([Ff]erdium)$]] }, float = true })
hl.window_rule({ match = { title = [[^(Picture-in-Picture)$]] }, float = true })
-- pypr dropdown terminal
hl.window_rule({ match = { class = [[^(pypr-term)$]] }, float = true })
hl.window_rule({ match = { class = [[^(pypr-term)$]] }, center = true })
hl.window_rule({ match = { class = [[^(pypr-term)$]] }, size = { "60%", "70%" } })
-- Float popups / dialogues (but not main windows)
hl.window_rule({ match = { class = [[^(codium|codium-url-handler|VSCodium)$]], title = [[negative:(.*codium.*|.*VSCodium.*)]] }, float = true })
hl.window_rule({ match = { class = [[^(com.heroicgameslauncher.hgl)$]], title = [[negative:(Heroic Games Launcher)]] }, float = true })
hl.window_rule({ match = { class = [[^([Ss]team)$]], title = [[negative:^([Ss]team)$]] }, float = true })
hl.window_rule({ match = { class = [[^([Tt]hunar)$]], title = [[negative:(.*[Tt]hunar.*)]] }, float = true })
hl.window_rule({ match = { initial_title = [[^(Add Folder to Workspace)$]] }, float = true })
hl.window_rule({ match = { initial_title = [[^(Add Folder to Workspace)$]] }, size = { "70%", "60%" } })
hl.window_rule({ match = { initial_title = [[^(Open Files)$]] }, float = true })
hl.window_rule({ match = { initial_title = [[^(Open Files)$]] }, size = { "70%", "60%" } })

-- ---------- OPACITY (active / inactive) ----------
hl.window_rule({ match = { tag = "browser*" }, opacity = "0.9 0.7" })
hl.window_rule({ match = { tag = "projects*" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "im*" }, opacity = "0.94 0.86" })
hl.window_rule({ match = { tag = "multimedia*" }, opacity = "0.94 0.86" })
hl.window_rule({ match = { tag = "file-manager*" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "terminal*" }, opacity = "0.8 0.7" })
hl.window_rule({ match = { tag = "settings*" }, opacity = "0.8 0.7" })
hl.window_rule({ match = { tag = "viewer*" }, opacity = "0.82 0.75" })
hl.window_rule({ match = { tag = "wallpaper*" }, opacity = "0.9 0.7" })
hl.window_rule({ match = { class = [[^(gedit|org.gnome.TextEditor|mousepad)$]] }, opacity = "0.8 0.7" })
hl.window_rule({ match = { class = [[^(deluge)$]] }, opacity = "0.9 0.8" })
hl.window_rule({ match = { class = [[^(im.riot.Riot)$]] }, opacity = "0.9 0.8" })
hl.window_rule({ match = { class = [[^(seahorse)$]] }, opacity = "0.9 0.8" })
hl.window_rule({ match = { title = [[^(Picture-in-Picture)$]] }, opacity = "0.95 0.75" })
hl.window_rule({ match = { class = [[^(code)$]] }, opacity = "0.95 0.8" })

-- ---------- SIZE ----------
hl.window_rule({ match = { tag = "wallpaper*" }, size = { "70%", "70%" } })
hl.window_rule({ match = { tag = "settings*" }, size = { "70%", "70%" } })
hl.window_rule({ match = { class = [[^([Ww]hatsapp-for-linux)$]] }, size = { "60%", "70%" } })
hl.window_rule({ match = { class = [[^([Ff]erdium)$]] }, size = { "60%", "70%" } })

-- ---------- PINNING / EXTRAS ----------
hl.window_rule({ match = { title = [[^(Picture-in-Picture)$]] }, pin = true })
hl.window_rule({ match = { title = [[^(Picture-in-Picture)$]] }, keep_aspect_ratio = true })

-- ---------- BLUR & FULLSCREEN ----------
hl.window_rule({ match = { tag = "games*" }, no_blur = true })
hl.window_rule({ match = { tag = "games*" }, fullscreen = true })

-- Deadlocked overlay fix (was last line of hyprland.conf)
hl.window_rule({ match = { title = [[^(deadlocked_overlay)$]] }, no_blur = true })

-- ---------- LAYER RULES ----------
hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0 })
