#!/bin/bash

# Obtener la lista de todos los sinks y almacenarlos en un array
sinks=($(pactl list short sinks | awk '{print $1}'))

# Obtener el sink actual
current_sink=$(pactl get-default-sink)

# Encontrar el índice del sink actual en la lista de sinks
current_index=-1
for i in "${!sinks[@]}"; do
    sink_name=$(pactl list short sinks | awk 'NR=='$((i + 1))'{print $2}')
    if [[ "$sink_name" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done

# Calcular el índice del siguiente sink
next_index=$(( (current_index + 1) % ${#sinks[@]} ))

# Cambiar al siguiente sink
pactl set-default-sink "${sinks[$next_index]}"

# Mover todas las aplicaciones de audio al nuevo sink
for input in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$input" "${sinks[$next_index]}"
done

# Imprimir el nuevo sink para confirmación
new_sink_name=$(pactl list short sinks | awk 'NR=='$((next_index + 1))'{print $2}')
echo "Dispositivo de salida cambiado a: $new_sink_name"
