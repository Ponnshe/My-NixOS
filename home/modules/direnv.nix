{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
