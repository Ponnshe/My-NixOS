{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:

{
  home.packages = with pkgs; [
    nyxt
  ];
}
