#!/usr/bin/env bash

STATE_FILE="/tmp/nervo_pomo"

timer() {
    local seconds=$(( $1 * 60 ))
    local mode=$2 # El icono
    
    while [ $seconds -gt 0 ]; do
        local MM=$((seconds / 60))
        local SS=$((seconds % 60))
        
        # %s para el icono, %02d para minutos, %02d para segundos
        printf "%02d:%02d %s\n" "$MM" "$SS" "$mode" > "$STATE_FILE"
        
        sleep 1
        : $((seconds--))
    done

}

run_cycle() {
    local work_min=$1
    local rest_min=$2

    # Fase de Trabajo
    timer "$work_min" "󰹡" 
    
    # Notificación previa al hachazo
    notify-send -u critical "DESCANSO" "Bloqueando en 5 segundos..."
    sleep 5

    timer "$rest_min" "󱘖" &
		TIMER_PID=$!
    
		hyprlock 

    # 4. Limpieza post-desbloqueo
    kill $TIMER_PID 2>/dev/null
}

# Parsing de argumentos (ej: 55,5 55,60)
for pair in "$@"; do
    IFS=',' read -r w r <<< "$pair"
    run_cycle "$w" "$r"
done

rm "$STATE_FILE"
