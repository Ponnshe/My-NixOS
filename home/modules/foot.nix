{ config, pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Hack Nerd Font:size=16"; # ajusta si usas otra fuente
        pad = "10x10 center";
      };

      colors-dark = {
        foreground = "f8f8f2";
        background = "1a1a1f";
        selection-foreground = "ffffff";
        selection-background = "44475a";

        regular0  = "21222c";  # black
        regular1  = "ff5555";  # red
        regular2  = "fce803";  # green-ish (mod)
        regular3  = "f1fa8c";  # yellow
        regular4  = "bd93f9";  # blue
        regular5  = "ff79c6";  # magenta
        regular6  = "8be9fd";  # cyan
        regular7  = "f8f8f2";  # white

        bright0   = "6272a4";  # bright black
        bright1   = "ff6e6e";  # bright red
        bright2   = "69ff94";  # bright green
        bright3   = "ffffa5";  # bright yellow
        bright4   = "d6acff";  # bright blue
        bright5   = "ff92df";  # bright magenta
        bright6   = "a4ffff";  # bright cyan
        bright7   = "ffffff";  # bright white
      };
      cursor = {
        blink = "yes";
      };
    };
  };
}
