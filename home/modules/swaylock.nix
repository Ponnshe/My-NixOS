{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
  programs.swaylock= {
    enable = true;
  };
}
