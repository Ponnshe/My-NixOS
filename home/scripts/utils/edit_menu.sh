MODULES_PATH="$1"
SCRIPT_PATH="$2"
HOME_PATH="$3"
CONF_PATH="$4"

if [ ! -d "$MODULES_PATH" ]; then notify-send "Error" "Dir Modulos no existe: $MODULES_PATH"; exit 1; fi
if [ ! -d "$SCRIPT_PATH" ]; then notify-send "Error" "Dir Scripts no existe: $SCRIPTS_PATH"; exit 1; fi
if [ ! -f "$HOME_PATH" ];   then notify-send "Error" "Home.nix no existe: $HOME_PATH"; exit 1; fi
if [ ! -f "$CONF_PATH" ];   then notify-send "Error" "Config.nix no existe: $CONF_PATH"; exit 1; fi

OP_MOD="1. Modules"
OP_SCR="2. Scripts"
OP_HM="3. Home Manager"
OP_CFG="4. System Config"

choice=$(echo -e "$OP_MOD\n$OP_SCR\n$OP_HM\n$OP_CFG" | wofi --show dmenu --prompt "Edit:")

case "$choice" in
    "$OP_MOD")
				bash "${SCRIPT_PATH}/utils/edit_file.sh ${MODULES_PATH} nix"
        ;;
    "$OP_SCR")
				bash "${SCRIPT_PATH}/utils/edit_file.sh ${SCRIPT_PATH} sh"
        ;;
    "$OP_HM")
        foot --app-id "my-file-editor" -e nvim "$HOME_PATH"
        ;;
    "$OP_CFG")
        foot --app-id "my-file-editor" -e nvim "$CONF_PATH"
        ;;
esac
