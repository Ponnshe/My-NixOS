# Renderizador de imagenes

{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
  programs.imv = {
    enable = true;
  };
}
