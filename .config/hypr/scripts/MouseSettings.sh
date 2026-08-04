#!/usr/bin/env bash

# Ajusta la sensibilidad del ratón según haya un mouse externo o solo touchpad.
# Usa la API de Hyprland (hyprctl devices) en vez de libinput, que puede no
# estar instalado. Funciona igual en el PC y en el portátil.

mouse_count=$(hyprctl -j devices | python3 -c "
import json, sys
d = json.load(sys.stdin)
# Filtra punteros virtuales y de control del teclado: solo cuentan ratones reales
skip = ('virtual', 'consumer', 'system', 'control', 'keyboard')
mice = [m for m in d.get('mice', []) if not any(k in m['name'].lower() for k in skip)]
print(len(mice))
")

if [ "${mouse_count:-0}" -gt 0 ]; then
  # Mouse externo conectado → sensibilidad baja
  hyprctl keyword input:sensitivity -0.8
  echo "Mouse detectado ($mouse_count): sensibilidad baja (-0.8)"
else
  # Solo touchpad → sensibilidad más alta
  hyprctl keyword input:sensitivity 0
  echo "Touchpad activo: sensibilidad alta (0)"
fi
