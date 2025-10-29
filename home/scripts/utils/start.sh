#!/usr/bin/env bash

TITLE="wallpaper"
VIDEO="$HOME/Home/Wallpapers/Animated/alone_purple.webm"
ARGS="--no-audio --profile=low-latency --loop-playlist --quiet"

#setting wallpaper
# Fondo de pantalla animado optimizado
mpvpaper --title="${TITLE}" -o "$ARGS" "*" "$VIDEO" &
#Network-connection manager
nm-applet --indicator &
#Terminal
foot &
#Status Bar
waybar &
#Emacs
emacs &
