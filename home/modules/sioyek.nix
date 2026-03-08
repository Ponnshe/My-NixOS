{ config, pkgs, ... }:

{
  programs.sioyek = {
    enable=true;
    config = {
      "startup_commands" = [ "toggle_dark_mode" ];
      "ruler_mode" = "1";
    };
  };
}
