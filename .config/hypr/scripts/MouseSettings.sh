#!/usr/bin/env bash

# Detectar si hay un mouse externo conectado
if libinput list-devices | grep -q "Mouse"; then
  # Mouse conectado → baja sensibilidad
  hyprctl keyword input:sensitivity -0.8
  echo "Mouse detectado: sensibilidad baja"
else
  # Solo touchpad → sensibilidad más alta
  hyprctl keyword input:sensitivity 0
  echo "Touchpad activo: sensibilidad alta"
fi
