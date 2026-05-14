#!/usr/bin/env bash

# Directorio local de destino
BASE_DIR="$HOME/Home/Studying/Uba/Semester5/programacion_concurrente"
ACT_DIR="$BASE_DIR/actividades"
CLA_DIR="$BASE_DIR/clases_drive"

mkdir -p "$ACT_DIR" "$CLA_DIR"

# Operación 1: PO -> Actividades
rclone copy material_concu:PO "$ACT_DIR" \
    --update \
    --verbose \
    --transfers 4

# Operación 2: TO -> Clases
rclone copy material_concu:TO "$CLA_DIR" \
    --update \
    --verbose \
    --transfers 4
