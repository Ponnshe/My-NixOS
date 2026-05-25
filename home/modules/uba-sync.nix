{ config, pkgs, ... }:

let
  orgTaskGenerator = pkgs.writeShellScriptBin "generar-tareas-uba" ''
    TARGET_ORG="$HOME/org/agenda/tareas.org"
    DIRS=(
      "$HOME/Home/Studying/Uba/Semester5/programacion_concurrente/actividades"
      "$HOME/Home/Studying/Uba/Semester5/programacion_concurrente/clases_drive"
      "$HOME/Home/Studying/Uba/Semester5/ciencia_datos/clases_drive"
    )
    MARKER="$HOME/.cache/uba_last_sync"

    [ ! -f "$MARKER" ] && ${pkgs.coreutils}/bin/touch -d "1970-01-01" "$MARKER"

    for ACT_DIR in "''${DIRS[@]}"; do
      # 1. Resolución del tag de Materia
      MATERIA_TAG="general"
      [[ "$ACT_DIR" == *"programacion_concurrente"* ]] && MATERIA_TAG="concu"
      [[ "$ACT_DIR" == *"cdd"* ]] && MATERIA_TAG="cdd"

      # 2. Resolución del tag de Tipo de Tarea
      TYPE_TAG="general"
      [[ "$ACT_DIR" == *"actividades"* ]] && TYPE_TAG="tarea"
      [[ "$ACT_DIR" == *"clases_drive"* || "$ACT_DIR" == *"clases"* ]] && TYPE_TAG="teoria"

      mkdir -p "$ACT_DIR"

      ${pkgs.findutils}/bin/find "$ACT_DIR" -type f -name "*.pdf" -newer "$MARKER" | while read -r file; do
        relpath=$(${pkgs.coreutils}/bin/realpath --relative-to="$ACT_DIR" "$file")
        timestamp=$(${pkgs.coreutils}/bin/date "+[%Y-%m-%d %a %H:%M]")
        deadline=$(${pkgs.coreutils}/bin/date -d "+5 days" "+<%Y-%m-%d %a>")
        
        # Inyección de los tags compuestos (Materia + Tipo)
        snippet="** TODO Procesar: ''${relpath%.*} :UBA:$MATERIA_TAG:$TYPE_TAG:
DEADLINE: $deadline
:PROPERTIES:
:CAPTURED: $timestamp
:END:
- Archivo local: [[file:$file][Abrir en Sioyek]]"

        ${pkgs.gawk}/bin/awk -v snip="$snippet" '
          /^\* Active/ { print snip; print; next }
          { print }
        ' "$TARGET_ORG" > "$TARGET_ORG.tmp" && ${pkgs.coreutils}/bin/mv "$TARGET_ORG.tmp" "$TARGET_ORG"
      done
    done

    ${pkgs.coreutils}/bin/touch "$MARKER"
  '';
in
{
  systemd.user.services.prefetch-uba = {
    Unit.Description = "Sincronización declarativa UBA (Concurrente + CDD)";
    Service = {
      Type = "oneshot";
      ExecStart = [
				# Concu
        "${pkgs.rclone}/bin/rclone copy material_concu:PO %h/Home/Studying/Uba/Semester5/programacion_concurrente/actividades --update"
        "${pkgs.rclone}/bin/rclone copy material_concu:TO %h/Home/Studying/Uba/Semester5/programacion_concurrente/clases_drive --update"
        
				# CDD
        "${pkgs.rclone}/bin/rclone copy \"material_cdd:Clases Teóricas\" %h/Home/Studying/Uba/Semester5/ciencia_datos/clases_drive --drive-export-formats pdf --update"
      ];
      ExecStartPost = "${orgTaskGenerator}/bin/generar-tareas-uba";
    };
  };

  systemd.user.timers.prefetch-uba = {
    Unit.Description = "Timer diario para pre-fetching de la UBA";
    Timer = {
      OnCalendar = "*-*-* 21:00:00"; 
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
