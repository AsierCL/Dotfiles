#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Keybind cheatsheet: shows this setup's shortcuts in rofi (read-only view).
# Opened with SUPER + ? (see lua/binds.lua).
# NOTE: curated list — update it when you add/change binds in lua/binds.lua.

ROFI_CONFIG="$HOME/.config/rofi/config-keybinds.rasi"

cat <<'EOF' | rofi -dmenu -i -p "Keybinds  (SUPER = Win)" -config "$ROFI_CONFIG"
SUPER + Return ─ terminal (kitty)          | SUPER + SHIFT + Return ─ scratchpad term
SUPER + D ─ app launcher (rofi)            | SUPER + T ─ files (nautilus)
SUPER + B ─ browser (zen)                  | SUPER + E ─ emoji picker
SUPER + V ─ clipboard history              | SUPER + ? ─ this cheatsheet | SUPER + N ─ notifications
SUPER + C ─ close window                   | SUPER + F ─ fullscreen (CTRL: fake/maximize)
SUPER + SHIFT + F ─ floating               | SUPER + I ─ toggle split layout
SUPER + arrows ─ focus                     | SUPER + SHIFT + arrows ─ move window
SUPER + CTRL + arrows ─ resize (hold)      | SUPER + drag / right-drag ─ move / resize
SUPER + 1..0 ─ workspace                   | SUPER + SHIFT + 1..0 ─ move window there
SUPER + CTRL + 1..0 ─ move silently        | SUPER + Tab ─ next monitor workspace
SUPER + U ─ special scratchpad             | SUPER + SHIFT + U ─ send to special
SUPER + SHIFT + T ─ scratchpad files       | SUPER + Z ─ desktop zoom (pypr)
SUPER + CTRL + S ─ night light toggle      | SUPER + ALT + K ─ keyboard layout (us/es) | SUPER + CTRL + A ─ audio output
SUPER + Print ─ screenshot                 | + SHIFT area · + CTRL 5s delay
ALT + Print ─ active window shot           | F6 variants (laptop, same mods)
ALT + Tab ─ cycle floating on top          | SUPER + scroll ─ prev/next workspace
CTRL + ALT + Delete ─ exit Hyprland        | CTRL + ALT + L ─ lock · P ─ power menu
3-finger ←/→ ─ workspaces · ↑ fullscreen · ↓ close   | 4-finger ← float · pinch overview
XF86 keys ─ volume / mic / brightness / touchpad / media / airplane / sleep
EOF
