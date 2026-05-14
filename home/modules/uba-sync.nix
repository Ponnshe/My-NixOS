{ config, pkgs, ... }:

let
  orgTaskGenerator = pkgs.writeShellScriptBin "generar-tareas-uba" ''
    TARGET_ORG="$HOME/org/agenda/tareas.org"
    ACT_DIR="$HOME/Home/Studying/Uba/Semester5/programacion_concurrente/actividades"
    MARKER="$HOME/.cache/uba_last_sync"

    [ ! -f "$MARKER" ] && ${pkgs.coreutils}/bin/touch -d "1970-01-01" "$MARKER"

    ${pkgs.findutils}/bin/find "$ACT_DIR" -type f -name "*.pdf" -newer "$MARKER" | while read -r file; do
      filename=$(${pkgs.coreutils}/bin/basename "$file")
      timestamp=$(${pkgs.coreutils}/bin/date "+[%Y-%m-%d %a %H:%M]")
      deadline=$(${pkgs.coreutils}/bin/date -d "+5 days" "+<%Y-%m-%d %a>")
      
      # Generar el bloque Org anidado (Nivel 2) con tags
      snippet="** TODO Procesar consigna: ''${filename%.*} :UBA:concu:
DEADLINE: $deadline
:PROPERTIES:
:CAPTURED: $timestamp
:END:
- Ejecución: [[file:$file][Abrir PDF en Sioyek]]"

      # Inyección atómica: busca la línea que empieza por '* Active', imprime el snippet antes, y sigue
      ${pkgs.gawk}/bin/awk -v snip="$snippet" '
        /^\* Active/ { print snip; print; next }
        { print }
      ' "$TARGET_ORG" > "$TARGET_ORG.tmp" && ${pkgs.coreutils}/bin/mv "$TARGET_ORG.tmp" "$TARGET_ORG"
    done

    ${pkgs.coreutils}/bin/touch "$MARKER"
  '';
in
{
  systemd.user.services.prefetch-uba = {
    Unit.Description = "Sincronización declarativa de consignas UBA y Org-mode";
    Service = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.rclone}/bin/rclone copy material_concu:PO %h/Home/Studying/Uba/Semester5/programacion_concurrente/actividades --update --transfers 4"
        "${pkgs.rclone}/bin/rclone copy material_concu:TO %h/Home/Studying/Uba/Semester5/programacion_concurrente/clases_drive --update --transfers 4"
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
