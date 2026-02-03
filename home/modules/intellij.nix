{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    jetbrains.idea-community
    # Si quieres la versión Ultimate (requiere licencia):
    # jetbrains.idea-ultimate
    openjdk23  # Asegúrate de tener la versión correcta de JDK
    jdt-language-server
    maven
    gradle
  ];
}
