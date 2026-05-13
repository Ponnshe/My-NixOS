{ config, pkgs, ... }:

{
  programs.sioyek = {
    enable = true;
    config = {
      "startup_commands" = [ "toggle_dark_mode" ];
      "ruler_mode" = "1";
      "ruler_color" = "0.3 0.5 0.9 0.4";
      "visual_mark_color" = "0.3 0.5 0.9 0.4";
    };
  };
}
