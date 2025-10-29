{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:

{
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd"
    ];
  };
}
