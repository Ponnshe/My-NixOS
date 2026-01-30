#!/usr/bin/env bash

MODULES_PATH="$1"
SCRIPT_PATH="$2"
LIVE_SCRIPT_PATH="$3"
HOME_PATH="$4"
CONF_PATH="$5"

# --- 1. Debug de rutas (Si falla, ahora sí sabrás cuál fue) ---
# Corregido: Usamos las variables SINGULARES ($SCRIPT_PATH) que definiste arriba
if [ ! -d "$MODULES_PATH" ];     then notify-send "Error Fatal" "Dir Modules no existe:\n$MODULES_PATH"; exit 1; fi
if [ ! -d "$SCRIPT_PATH" ];      then notify-send "Error Fatal" "Dir Script Path (Store) no existe:\n$SCRIPT_PATH"; exit 1; fi
if [ ! -d "$LIVE_SCRIPT_PATH" ]; then notify-send "Error Fatal" "Dir Live Scripts no existe:\n$LIVE_SCRIPT_PATH"; exit 1; fi
if [ ! -f "$HOME_PATH" ];        then notify-send "Error Fatal" "Home.nix no existe:\n$HOME_PATH"; exit 1; fi
if [ ! -f "$CONF_PATH" ];        then notify-send "Error Fatal" "Config.nix no existe:\n$CONF_PATH"; exit 1; fi

# --- 2. Verificación del Sub-Script ---
# Esto es vital. Verificamos si edit_file.sh existe antes de intentar llamarlo.
# Ajusta "/utils/" si tu archivo está en la raíz de scripts.
EDITOR_SCRIPT="${SCRIPT_PATH}/utils/edit_file.sh"

if [ ! -f "$EDITOR_SCRIPT" ]; then
    # Intento de recuperación: ¿Quizás está en la raíz sin utils?
    if [ -f "${SCRIPT_PATH}/edit_file.sh" ]; then
        EDITOR_SCRIPT="${SCRIPT_PATH}/edit_file.sh"
    else
        notify-send "Error Crítico" "No encuentro edit_file.sh en:\n$EDITOR_SCRIPT"
        exit 1
    fi
fi

# --- 3. Menú ---
OP_MOD="1. Modules"
OP_SCR="2. Scripts"
OP_HM="3. Home Manager"
OP_CFG="4. System Config"

choice=$(echo -e "$OP_MOD\n$OP_SCR\n$OP_HM\n$OP_CFG" | wofi --show dmenu --prompt "Edit:")

# Si cancelas (Esc), salimos sin error
if [ -z "$choice" ]; then exit 0; fi

# --- 4. Ejecución ---
case "$choice" in
    "$OP_MOD")
        bash "$EDITOR_SCRIPT" "$MODULES_PATH" "nix"
        ;;
    "$OP_SCR")
        bash "$EDITOR_SCRIPT" "$LIVE_SCRIPT_PATH" "sh"
        ;;
    "$OP_HM")
        foot --app-id "my-file-editor" -e nvim "$HOME_PATH"
        ;;
    "$OP_CFG")
        foot --app-id "my-file-editor" -e nvim "$CONF_PATH"
        ;;
    *)
        notify-send "Error" "Opción no reconocida: $choice"
        ;;
esac
