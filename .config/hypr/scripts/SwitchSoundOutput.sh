#!/bin/bash

# This is for changing sound output devices with pavucontrol.



# Get the list of available output sinks with their names
mapfile -t SINKS < <(pactl list short sinks | cut -f2)
mapfile -t SINK_NAMES < <(pactl list sinks | grep 'device.description' | sed 's/.*= "\(.*\)".*/\1/')

# Get current default sink
CURRENT_SINK=$(pactl get-default-sink)

# Find current sink index
CURRENT_INDEX=-1
for i in "${!SINKS[@]}"; do
    if [[ "$CURRENT_SINK" =~ ${SINKS[$i]} ]]; then
        CURRENT_INDEX=$i
        break
    fi
done

# If current sink not found, start from beginning
if [ $CURRENT_INDEX -eq -1 ]; then
    CURRENT_INDEX=0
fi

# Calculate next sink index
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#SINKS[@]} ))

# Ensure we wrap around to 0 if we reach the end
if [ $NEXT_INDEX -ge ${#SINKS[@]} ]; then
    NEXT_INDEX=0
fi

NEXT_SINK="${SINKS[$NEXT_INDEX]}"
NEXT_SINK_NAME="${SINK_NAMES[$NEXT_INDEX]}"

# Set the next sink as default
pactl set-default-sink "$NEXT_SINK"

# Move all current playing audio streams to the new sink
if pactl list short sink-inputs | grep -q .; then
    pactl list short sink-inputs | while read -r stream; do
        stream_id=$(echo "$stream" | cut -f1)
        if [ -n "$stream_id" ]; then
            pactl move-sink-input "$stream_id" "$NEXT_SINK"
        fi
    done
fi

# Send notification with icon and timeout
notify-send "Audio Output Changed" "Switched to: $NEXT_SINK_NAME" -i audio-headphones -t 2000
