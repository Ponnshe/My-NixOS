#!/bin/bash
# Detectar si las animaciones están activas
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
SCRIPT_DIR="$1"

if [ ! -d "${SCRIPT_DIR}" ]; then
	notify-send "Error Dir: ${SCRIPT_DIR} does not exist"
	exit 1
fi

if [ ! -f "${SCRIPT_DIR}/utils/toggle_wallpaper.sh" ]; then
	notify-send "Error Script: ${SCRIPT_DIR}/utils/toggle_wallpaper.sh does not exist"
	exit 1
fi

bash "${SCRIPT_DIR}/utils/toggle_wallpaper.sh"


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
