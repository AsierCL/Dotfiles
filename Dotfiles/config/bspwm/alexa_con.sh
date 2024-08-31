#!/bin/bash

# Dirección MAC del dispositivo Bluetooth
DEVICE_MAC="10:BF:67:3D:92:FA"

# Función para enviar comandos a bluetoothctl
bluetoothctl_command() {
    echo -e "$1" | bluetoothctl
}

# Encender Bluetooth
bluetoothctl_command "power on"

# Establecer el dispositivo como de confianza
bluetoothctl_command "trust $DEVICE_MAC"

# Conectar al dispositivo
bluetoothctl_command "connect $DEVICE_MAC"

# Salir de bluetoothctl
bluetoothctl_command "exit"

# Ponerlo como salida por defecto
pactl set-default-sink bluez_sink.10_BF_67_3D_92_FA.a2dp_sink
