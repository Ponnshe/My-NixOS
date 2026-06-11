{ pkgs, ... }:
let
  # Creamos un script que maneja el lanzamiento de Emacs sin errores de escape
  qute-editor = pkgs.writeShellScript "qute-emacs-editor" ''
    # -c crea un frame GUI (arregla el portapapeles)
    # -F define el nombre del frame para Hyprland
    exec ${pkgs.emacs}/bin/emacsclient -c -F "((name . \"my-file-editor\"))" "$@"
  '';
in
{
  programs.qutebrowser = {
    enable = true;
    
    # Habilitar Widevine para YouTube, Netflix y servicios de Google
    package = pkgs.qutebrowser.override { enableWideVine = true; };

    # Motores de búsqueda rápidos
    searchEngines = {
      DEFAULT = "https://www.google.com/search?q={}";
      nw = "https://search.nixos.org/packages?query={}";
      no = "https://search.nixos.org/options?query={}";
      gh = "https://github.com/search?q={}";
      rs = "https://docs.rs/releases/search?query={}"; # Rust Docs
      tr = "https://www.tradingview.com/chart/?symbol={}"; # Trading
    };

    settings = {
			"zoom.default" = 150;
			"qt.args" = [ "disable-features=Translate" "disable-translate" ];

      # --- Comportamiento y Google ---
      "content.canvas_reading" = false;
      "content.webgl" = true;
      "content.media.audio_video_capture" = true;
      "content.geolocation" = true;
      "content.notifications.enabled" = true;
      "content.headers.accept_language" = "es-AR,es;q=0.9,en;q=0.8";

      # --- Estética Cyberpunk Violet ---
      "colors.webpage.darkmode.enabled" = true;
      "colors.webpage.bg" = "#1a1025"; # Violeta profundo
      "colors.webpage.preferred_color_scheme" = "dark";
      
      # --- SOLUCIÓN ERROR image_8a3215.png ---
      # Se elimina grayscale.pre_rendering porque ya no existe en Qt6
      # En su lugar, usamos el algoritmo por defecto optimizado
      "colors.webpage.darkmode.algorithm" = "lightness-cielab"; 

      # --- Interfaz (Tabs y Editor) ---
      "tabs.position" = "left";
			"tabs.show" = "switching";
      "tabs.favicons.show" = "always";
      "tabs.title.format" = "{index}: {audio}{current_title}";
#			"editor.command" = ["foot" "-a" "my-file-editor" "emacsclient" "-nw" "{}"];
			"editor.command" = [ "${qute-editor}" "{}" ];
      "content.blocking.method" = "both";

      # --- Colores de Enlaces y UI ---
      "colors.hints.bg" = "#f78400"; # Naranja de tus bordes de Hyprland
      "colors.hints.fg" = "#1a1025";
      "colors.statusbar.url.fg" = "#e4b5ff";
      "colors.statusbar.url.success.http.fg" = "#33ccff"; # Azul neón
      "colors.statusbar.url.success.https.fg" = "#d29eff"; # Malva de tu CSS

      # --- Completación (Qt6 Fix) ---
      "colors.completion.fg" = "#e4b5ff";
      "colors.completion.odd.bg" = "#1a1025";
      "colors.completion.even.bg" = "#241e33";
      "colors.completion.item.selected.bg" = "#b50cf7"; # Violeta Hyprland
      "colors.completion.match.fg" = "#33ccff";

      # --- Barra de Pestañas ---
      "colors.tabs.bar.bg" = "#1a1025";
      "colors.tabs.selected.even.bg" = "#b50cf7";
      "colors.tabs.selected.odd.bg" = "#b50cf7";
      "colors.tabs.indicator.start" = "#33ccff";
      "colors.tabs.indicator.stop" = "#d29eff";

      # --- Barra de Estado ---
      "colors.statusbar.normal.bg" = "#1a1025";
      "colors.statusbar.insert.bg" = "#d29eff";
      "colors.statusbar.insert.fg" = "#1a1025";
    };

    aliases = {
      "gdrive" = "open -t https://drive.google.com";
      "gdocs" = "open -t https://docs.google.com";
      "gmeet" = "open -t https://meet.google.com";

			"trading" = "open https://www.tradingview.com/chart/JrFTObOt/?symbol=BINANCE%3ABTCUSDT ;; tab-only ;; open -t https://v3.tealstreet.io/es-AR/trade ;; open -t https://calc.trade/ ;; open -t https://docs.google.com/spreadsheets/d/1lVaMbr1qmcbSi1lUQT7LvLKc7PkyZbQbkEgPrraBJ4A/edit?gid=0#gid=0";
    };

		keyBindings = {
      normal = {
        ",m" = "spawn mpv {url}";
        ",p" = "config-cycle content.proxy system none";
        
        # --- NUEVO: Atajo rápido para Trading ---
        # Al presionar ',t' se ejecutará el alias 'trading'
        ",t" = "trading";
      };
    };

    # --- Persistencia de la solución de Google ---
    extraConfig = ''
# Definimos el UA que te funcionó
ua_google = "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135"
      
# Aplicar a login y a todo el ecosistema Google para evitar el error de "No puedes acceder"
config.set('content.headers.user_agent', ua_google, 'https://accounts.google.com/*')
config.set('content.headers.user_agent', ua_google, 'https://*.google.com/*')
config.set('input.insert_mode.auto_load', True)
    '';
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    };
  };

  # Variable de entorno para scripts y terminal
  home.sessionVariables = {
    BROWSER = "qutebrowser";
  };
}
