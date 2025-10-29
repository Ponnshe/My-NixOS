{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:

{
  programs.sioyek = {
    enable=true;
    config = {
      "startup_commands" = "toggle_dark_mode";
      "ruler_mode" = "1";
    };
  };
}
