#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

# Lock inmediato (no depende de hypridle): si hyprlock ya corre, no duplicar.
# Si hypridle está presente, su lock_cmd ve hyprlock en marcha vía pidof y
# no lo relanza al recibir el loginctl lock-session de abajo.
pidof hyprlock || hyprlock -q &

loginctl lock-session