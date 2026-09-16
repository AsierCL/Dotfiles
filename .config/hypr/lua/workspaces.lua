-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */ --
-- WORKSPACE RULES (<- workspaces.conf)
-- HOW TO: hl.workspace_rule({ workspace = "<id|name:…|special:…>", monitor = "…",
--   gaps_in = 0, gaps_out = 0, no_border = true, decorate = false,
--   default = true, on_created_empty = "[float] firefox", … })
-- Discord (ws 7) and Spotify (ws 10) pinned to secondary monitor (HDMI-A-1).
-- On laptop (no HDMI-A-1) the rule falls back, only the number applies.

hl.workspace_rule({ workspace = "7", monitor = "desc:Fujitsu Siemens Computers GmbH P24W-6 LED YV5L004610" })
hl.workspace_rule({ workspace = "10", monitor = "desc:Fujitsu Siemens Computers GmbH P24W-6 LED YV5L004610" })

-- Examples (from old workspaces.conf comments):
-- hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
-- hl.workspace_rule({ workspace = "name:coding", no_rounding = true, decorate = false, gaps_in = 0, gaps_out = 0, no_border = true, monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "8", border_size = 8 })
-- hl.workspace_rule({ workspace = "5", on_created_empty = "[float] firefox" })
-- hl.workspace_rule({ workspace = "special:scratchpad", on_created_empty = "foot" })
