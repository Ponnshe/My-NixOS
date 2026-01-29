#!/usr/bin/env bash

# Define tus rutas de scripts usando la variable que ya tienes
BASE_DIR="$SCRIPTS_PATH/utils"

# 1. Listar solo los archivos de la carpeta utils
# 2. Pasarlos a wofi en modo dmenu
# 3. Ejecutar la opción seleccionada
choice=$(ls "$BASE_DIR" | wofi --show dmenu --prompt "Ejecutar utilidad:")

if [ -n "$choice" ]; then
    bash "$BASE_DIR/$choice"
fi
