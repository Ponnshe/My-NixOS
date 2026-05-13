{ config, pkgs, scriptsPath, ... }:

let
 liveModules = "${config.home.homeDirectory}/nixos-config/home/modules";
 liveScripts = "${config.home.homeDirectory}/nixos-config/home/scripts";
 liveHomeFile = "${config.home.homeDirectory}/nixos-config/home/default.nix";
 liveConfigurationFile = "${config.home.homeDirectory}/nixos-config/configuration.nix";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      monitor = [
        "eDP-1,highrr,0x0,1.0"
        "HDMI-A-1,preferred,auto,1"
      ];

      workspace = [
        "1, monitor:HDMI-A-1"
        "2, monitor:HDMI-A-1"
        "3, monitor:eDP-1"
        "4, monitor:HDMI-A-1"
      ];

      env = [
        "XCURSOR_SIZE,24"
      ];

      input = {
        kb_layout = "latam";
        kb_options = "ctrl:nocaps";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = "yes";
          scroll_factor = 0.3;
        };
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = false;
        "col.active_border"="rgba(b50cf7ff) rgba(f78400ff) 45deg";
        "col.inactive_border" = "rgba(8e659cff) rgba(566185ff) 45deg";
      };

			binds = {
				movefocus_cycles_fullscreen = true;
			};

      decoration = {
        rounding = 10;
        active_opacity = 0.87;
        inactive_opacity = 0.85;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          ignore_opacity = false;
          brightness = 0.5;
          vibrancy = 0.8;
          vibrancy_darkness = 1.8;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.16, 1.0, 0.3, 1.0";
        animation = [
          "windows, 1, 1, myBezier"
          "windowsIn, 1, 1, default, gnome"
          "windowsOut, 1, 1, default, slide 20%"
          "border, 1, 3, default"
          "borderangle, 1, 2, default"
          "fade, 1, 2, default"
          "workspaces, 1, 3, default, slidefade 40%"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        orientation = "left";
      };

      gesture = "3, horizontal, workspace";

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      # Ventanas específicas
      windowrule = [
        "match:class Emacs, workspace 3 silent"
        "match:class Vivaldi-stable, workspace 2 silent"
				"match:class ^(org.qutebrowser.qutebrowser)$, workspace 2 silent"
        "match:class foot, workspace 1"
        "match:class sioyek, workspace 3 silent, fullscreen on"

				#My file editor rules
				"match:class ^my-file-editor, workspace special:magic, float on, center on, dim_around on, size monitor_w*0.8 monitor_h*0.8"
				"match:title ^my-file-editor, workspace special:magic, float on, center on, dim_around on, size monitor_w*0.8 monitor_h*0.8"

				#imv rules
				"match:class ^imv, workspace special:magic, float on, center on, dim_around on, size monitor_w*0.8 monitor_h*0.8"

				"match:class ^pomo-break, fullscreen on, stay_focused on, monitor eDP-1"
      ];

			layerrule = [
				"match:namespace wofi, dim_around on"
			];

      bind = [
        "$mainMod, Q, exec, foot"
        "$mainMod, W, killactive"
        "$mainMod, SPACE, togglefloating"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, S, exec, bash ${scriptsPath}/utils/launcher.sh ${scriptsPath}/utils"
        "$mainMod, E, exec, bash ${scriptsPath}/utils/edit_menu.sh ${liveModules} ${scriptsPath} ${liveScripts} ${liveHomeFile} ${liveConfigurationFile}"
        "$mainMod, P, pseudo"
        "$mainMod, V, togglesplit"
        "$mainMod, f, fullscreen"
        "$mainMod, M, togglespecialworkspace, magic"
        "$mainMod SHIFT, M, movetoworkspace, special:magic"
        # Move focus window
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod, Tab, cyclenext"


        # Utils
        "$mainMod SHIFT, S, exec, ${scriptsPath}/utils/screenshot.sh"
        "$mainMod SHIFT, R, exec, reboot"

				# Brightness
				", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
				", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        # Change windows position
        "$mainMod CTRL, l, swapwindow, r"
        "$mainMod CTRL, k, swapwindow, u"
        "$mainMod CTRL, j, swapwindow, d"
        "$mainMod CTRL, h, swapwindow, l"

        # Resize windows
        "$mainMod ALT, l, resizeactive, 10 0"
        "$mainMod ALT, k, resizeactive, 0 -10"
        "$mainMod ALT, j, resizeactive, 0 10"
        "$mainMod ALT, h, resizeactive, -10 0"

				# Wallpapers commands
				"$mainMod ALT, W, exec, bash ${scriptsPath}/utils/toggle_wallpaper.sh"

				# Waybar command
				"$mainMod ALT, B, exec, bash ${scriptsPath}/utils/toggle_waybar.sh"

				# Performance command
				"$mainMod ALT, P, exec, bash ${scriptsPath}/utils/toggle_perf.sh ${scriptsPath}"
      ] ++
        (builtins.concatLists (builtins.genList (i:
          let n = builtins.toString i;
          in [
            "$mainMod, ${n}, workspace, ${n}"
            "$mainMod SHIFT, ${n}, movetoworkspace, ${n}"
          ]
        ) 10));

      bindm = [
        "$mainMod CTRL, mouse:272, movewindow"
        "$mainMod, mouse:272, resizewindow"
      ];

      exec-once = [
        "bash ${scriptsPath}/utils/start.sh"
        "bash ~/scripts/clean_auto_saves.sh"
				"hyprsunset"
      ];

			extraConfig = ''
        submap = break
        bind = CONTROL SHIFT, Escape, submap, reset
        submap = reset
      '';
    };

  };

  services.hyprsunset = {
    enable = true;
    settings = {
			profile = [
        {
          time = "09:00";
          temperature = 6500;
          gamma = 1.0;
        }
        {
          time = "22:00";
          temperature = 3500;
          gamma = 0.8;
        }
      ];
    };
  };
}
