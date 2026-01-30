#!/usr/bin/env bash

MODULE_DIR="$1"

if [ ! -d "$MODULE_DIR" ]; then
	notify-send "Error de module directory does not exist"
	exit 1
fi

cd "$MODULE_DIR" || exit

choice=$(find . -type f -name "*.nix" | sed 's|^\./||' | wofi --show dmenu -prompt "Edit config module:")

if [ -n "$choice" ]; then
	foot -e nvim "$MODULE_DIR/$choice"
fi
