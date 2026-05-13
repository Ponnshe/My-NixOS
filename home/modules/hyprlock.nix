{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading = true;
        grace = 0;
        hide_cursor = true;
      };

      background = [
        {
          path = "/home/ponnshe/Home/Wallpapers/purpleRain.png";
          color = "rgb(0, 31, 63)"; # --azul-elegante
          blur_passes = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] cat /tmp/nervo_pomo";
          color = "rgb(228, 181, 255)"; # --lila-claro
          font_size = 64;
          font_family = "Hack Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "250, 60";
          outline_thickness = 3;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          
          # Gradiente basado en col.active_border de Hyprland
          outer_color = "rgb(181, 12, 247) rgb(247, 132, 0)"; 
          inner_color = "rgb(0, 31, 63)"; # --azul-elegante
          font_color = "rgb(127, 219, 255)"; # --azul-cielo-claro
          
          fade_on_empty = false;
          placeholder_text = "<span foreground='##ca89f0'><i>Password...</i></span>"; # --lavanda-claro
          hide_input = false;
          
          check_color = "rgb(191, 0, 255)"; # --violeta-intenso
          fail_color = "rgb(255, 111, 145)"; # Color de error de tus botones activos
          
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
