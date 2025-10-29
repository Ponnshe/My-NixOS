{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
  programs.fzf = {
    enable = true;
  };
}
