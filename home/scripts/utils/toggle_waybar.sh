#!/usr/bin/env bash

if pgrep "waybar" > /dev/null; then
 kill "$(pgrep waybar)"
else
  waybar &
fi
