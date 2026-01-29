#!/bin/bash
# Detectar si las animaciones están activas
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$HYPRGAMEMODE" = 1 ] ; then
    # MODO ALTO RENDIMIENTO (Duro y directo)
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword decoration:active_opacity 1.0;\
        keyword decoration:inactive_opacity 1.0;\
        keyword decoration:rounding 0"
    notify-send "Modo Combate" "Recursos liberados para trabajar."
else
    # MODO ESTÉTICO (Tu esencia)
    hyprctl --batch "\
        keyword animations:enabled 1;\
        keyword decoration:blur:enabled 1;\
        keyword decoration:active_opacity 0.87;\
        keyword decoration:inactive_opacity 0.75;\
        keyword decoration:rounding 10"
    notify-send "Modo Relax" "Estética restaurada."
fi
