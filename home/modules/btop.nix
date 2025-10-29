{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
  programs.btop= {
    enable = true;
  };
}
