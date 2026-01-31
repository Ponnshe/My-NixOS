{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
  programs.mpv = {
    enable = true;
  };
}
