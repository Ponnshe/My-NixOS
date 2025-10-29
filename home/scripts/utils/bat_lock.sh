#!/usr/bin/env bash

LOW_THRESHOLD=40
HIGH_THRESHOLD=80

BAT_PATH="/sys/class/power_supply/BAT1"

CHARGE_ORDER="charge"
DISC_ORDER="disconnect"

notify_and_lock() {
  local msg="$1"
  local order="$2"

  notify-send -u critical "⚠️ Acción requerida" "$msg"
  sleep 5
  swaylock -f

  while true; do
    local capacity=$(cat "$BAT_PATH/capacity")
    local status=$(cat "$BAT_PATH/status")

    if [[ "$order" == "$CHARGE_ORDER" && "$status" == "Charging" ]]; then
      break
    elif [[ "$order" == "$DISC_ORDER" && "$status" != "Charging" ]]; then
      break
    fi

    sleep 3
    swaylock -f  # relock por si desbloqueó sin cumplir
  done
}

while true; do
  capacity=$(cat "$BAT_PATH/capacity")
  status=$(cat "$BAT_PATH/status")

  if [[ "$capacity" -lt $LOW_THRESHOLD && "$status" != "Charging" ]]; then
    notify_and_lock "Batería baja ($capacity%). Por favor conecta el cargador." "$CHARGE_ORDER"
  elif [[ "$capacity" -gt $HIGH_THRESHOLD && "$status" == "Charging" ]]; then
    notify_and_lock "Carga alta ($capacity%). Por favor desconecta el cargador." "$DISC_ORDER"
  fi

  sleep 30
done
