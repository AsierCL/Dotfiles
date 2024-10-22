#!/bin/bash

max_length=10   # Ajusta este valor según el tamaño del módulo
scroll_speed=1  # Ajusta la velocidad de desplazamiento

scroll_text() {
    local text="$1"
    local length=${#text}
    local offset=$2
    if [ $length -le $max_length ]; then
        printf "%-${max_length}s" "$text"  # Añadir espacios en blanco para relleno
    else
        local start=$((offset % length))
        if [ $((start + max_length)) -le $length ]; then
            echo "${text:start:max_length}"
        else
            local end=$((start + max_length - length))
            echo "${text:start:length}${text:0:end}"
        fi
    fi
}

player_status=$(playerctl status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    title=$(playerctl metadata title)
    offset_file="/tmp/polybar_player_offset"
    if [ ! -f "$offset_file" ]; then
        echo "0" > "$offset_file"
    fi
    offset=$(cat "$offset_file")
    new_offset=$((offset + scroll_speed))
    echo "$new_offset" > "$offset_file"
    echo " {$(scroll_text "$title       " $offset)}"
elif [ "$player_status" = "Paused" ]; then
    title=$(playerctl metadata title)
    offset_file="/tmp/polybar_player_offset"
    if [ ! -f "$offset_file" ]; then
        echo "0" > "$offset_file"
    fi
    offset=$(cat "$offset_file")
    new_offset=$((offset + scroll_speed))
    echo "$new_offset" > "$offset_file"
    echo " {$(scroll_text "$title       " $offset)}"
else
    offset_file="/tmp/polybar_player_offset"
    if [ ! -f "$offset_file" ]; then
        echo "0" > "$offset_file"
    fi
    offset=$(cat "$offset_file")
    new_offset=$((offset + scroll_speed))
    echo "$new_offset" > "$offset_file"
    echo " {$(scroll_text "|Nada sonando|       " $offset)}"
fi
