#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

# Lock inmediato (no depende de hypridle).
# El guard antiguo (pidof hyprlock) fallaba si quedaba un hyprlock huérfano
# sin bloquear: no lanzaba otro y el atajo parecía no funcionar. Ahora se
# comprueba el estado real del compositor; un proceso huérfano se reinicia.
if hyprctl locked 2>/dev/null | grep -qx true; then
  exit 0
fi

pkill -x hyprlock 2>/dev/null
sleep 0.2
hyprlock -q &

loginctl lock-session
