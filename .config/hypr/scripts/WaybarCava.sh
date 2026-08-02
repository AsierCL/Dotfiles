#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Not my own work. This was added through Github PR. Credit to original author
# Multi-monitor safe: each waybar bar gets its own cava slot, so instances
# do not kill each other's cava via a shared config file.

#----- Optimized bars animation without much CPU usage increase --------
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"

# Calculate the length of the bar outside the loop
bar_length=${#bar}

# Create dictionary to replace char with bar
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

# --- Per-bar slot allocation (atomic via mkdir) ---
SLOT_DIR="/tmp/waybar_cava_slots"
mkdir -p "$SLOT_DIR"

SLOT=""
for slot in 0 1 2 3 4 5; do
    if mkdir "$SLOT_DIR/$slot" 2>/dev/null; then
        SLOT="$slot"
        break
    fi
done
if [ -z "$SLOT" ]; then
    SLOT=0
fi

config_file="/tmp/bar_cava_config_$SLOT"

# Clean up this slot's cava and free the slot on exit
cleanup() {
    pkill -f "cava -p $config_file" 2>/dev/null
    rmdir "$SLOT_DIR/$SLOT" 2>/dev/null
}
trap cleanup EXIT

# Kill a stale cava from a previous instance of this same slot
pkill -f "cava -p $config_file" 2>/dev/null

# Create cava config
cat >"$config_file" <<EOF
[general]
# Older systems show significant CPU use with default framerate
# Setting maximum framerate to 30
# You can increase the value if you wish
framerate = 30
bars = 10

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Read stdout from cava and perform substitution in a single sed command
cava -p "$config_file" | sed -u "$dict"
