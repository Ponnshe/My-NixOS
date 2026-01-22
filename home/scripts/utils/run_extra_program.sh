#!/usr/bin/env bash

# Ruta base configurada
BASE_PATH="~/nixos-config/extra-apps"

# Verificar que se usó la flag y se pasó un nombre
if [[ "$1" == "-appimg" ]] && [[ -n "$2" ]]; then
    APP_NAME="$2"
    TARGET_DIR="$BASE_PATH/$APP_NAME"

    # 1. Verificar si la carpeta existe
    if [[ ! -d "$TARGET_DIR" ]]; then
        echo "❌ Error: La carpeta '$TARGET_DIR' no existe."
        exit 1
    fi

    # 2. Buscar el archivo .AppImage dentro de la carpeta
    # (head -n 1 asegura que tomamos solo uno si hubiese varios)
    APP_FILE=$(find "$TARGET_DIR" -maxdepth 1 -name "*.AppImage" | head -n 1)

    # 3. Verificar si se encontró el archivo
    if [[ -z "$APP_FILE" ]]; then
        echo "❌ Error: No se encontró ningún archivo .AppImage dentro de '$APP_NAME'."
        exit 1
    fi

    # 4. Ejecutar el comando
    echo "🚀 Lanzando: $(basename "$APP_FILE") con soporte Wayland..."
    
    appimage-run "$APP_FILE" \
        --no-sandbox \
        --enable-features=UseOzonePlatform \
        --ozone-platform=wayland

else
    echo "⚠️ Uso incorrecto."
    echo "Sintaxis: $0 -appimg <app_name>"
    exit 1
fi
