#!/usr/bin/env bash

BASE_DIR="$1"
EXTENSION="$2"

if [ ! -d "$BASE_DIR" ]; then
	notify-send "Error de {BASE_DIR} directory does not exist"
	exit 1
fi

cd "$BASE_DIR" || exit

choice=$(find . -type f -name "*.${EXTENSION}" | sed 's|^\./||' | wofi --show dmenu --prompt "Edit:")

if [ -n "$choice" ]; then
	foot --app-id "my-file-editor" -e nvim "$BASE_DIR/$choice"
fi
