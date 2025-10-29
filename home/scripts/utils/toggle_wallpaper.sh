#!/usr/bin/env bash

# Configuración
TITLE="wallpaper"
VIDEO="$HOME/Home/Wallpapers/Animated/alone_purple.webm"
ARGS="--no-audio --profile=low-latency --loop-playlist --quiet"

# Obtener el PID del proceso mpvpaper con el título deseado
PID=$(pgrep -af "mpvpaper.*--title=${TITLE}" | awk '{print $1}')

# Verificar si el proceso está corriendo
if [ -n "$PID" ]; then
    # Verificar si hay un mpv hijo asociado a ese mpvpaper
    if ! pgrep -P "$PID" | xargs ps -o comm= | grep -q mpv; then
        #notify-send "mpvpaper huérfano encontrado. Matando PID $PID"
        kill "$PID"
				sleep 0.5
				if kill -0 "$PID" 2>/dev/null; then
						#notify-send "El proceso $PID sigue vivo. Enviando SIGKILL..."
						kill -9 "$PID"
				fi
    else
        #notify-send "mpvpaper activo con mpv hijo. Deteniendo ambos..."
        pkill -f "mpv.*--title=${TITLE}"
    fi
else
    #notify-send "Iniciando mpvpaper..."
    mpvpaper --title="${TITLE}" -o "$ARGS" "*" "$VIDEO" &
fi
