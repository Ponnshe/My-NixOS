# Qutebrowser config
{ pkgs, ... }:

{
  programs.qutebrowser = {
    enable = true;
    
    # Habilitar Widevine para YouTube, Netflix y servicios de Google
    package = pkgs.qutebrowser.override { enableWideVine = true; };

    # Configuración de búsqueda rápida (motores de búsqueda)
    searchEngines = {
      DEFAULT = "https://www.google.com/search?q={}";
      nw = "https://search.nixos.org/packages?query={}";
      no = "https://search.nixos.org/options?query={}";
      gh = "https://github.com/search?q={}";
      rs = "https://docs.rs/releases/search?query={}"; # Documentación de Rust
      tr = "https://www.tradingview.com/chart/?symbol={}"; # Para tus trades (DXY, VIX)
    };

    settings = {
      # --- Solución para Google Apps ---
      # Forzar User Agent para el login de Google
      "content.headers.user_agent" = "Mozilla/5.0 (X11; Linux x86_64; rv:133.0) Gecko/20100101 Firefox/133.0";
      
      # Evitar que Google detecte el navegador como "no seguro"
      "content.canvas_reading" = false;
      "content.webgl" = true;

      # Permisos para Google Meet
      "content.media.audio_video_capture" = true;
      "content.geolocation" = true;
      "content.notifications.enabled" = true;

      # --- Estética y Comportamiento ---
      "colors.webpage.darkmode.enabled" = true; # Forzar modo oscuro
      "tabs.position" = "left"; # Tabs laterales (mejor para monitores anchos)
      "tabs.width" = "15%";
      "editor.command" = [ "emacsclient" "-c" "{}" ]; # Usa tu Emacs para editar campos de texto
      
      # Bloqueo de anuncios básico
      "content.blocking.method" = "both";

			# --- Paleta de colores (Basada en tus archivos) ---
			# Fondo: #001f3f (Azul Elegante de tu Waybar)
			# Texto: #e4b5ff (Lila Claro de tu Waybar)
			# Acento: #ca89f0 (Lavanda de tu Waybar)
			# Bordes: #b50cf7 (Violeta de tu Hyprland)

			"colors.completion.fg" = "#e4b5ff";
			"colors.completion.bg" = "#001f3f";
			"colors.completion.alternate.bg" = "#05294a";
			"colors.completion.category.fg" = "#ca89f0";
			"colors.completion.category.bg" = "#001f3f";
			"colors.completion.category.border.top" = "#001f3f";
			"colors.completion.category.border.bottom" = "#001f3f";
			"colors.completion.item.selected.fg" = "#ffffff";
			"colors.completion.item.selected.bg" = "#bf00ff"; # Violeta intenso
			"colors.completion.item.selected.border.top" = "#bf00ff";
			"colors.completion.item.selected.border.bottom" = "#bf00ff";
			"colors.completion.match.fg" = "#7FDBFF"; # Azul cielo vibrante

			"colors.statusbar.normal.fg" = "#e4b5ff";
			"colors.statusbar.normal.bg" = "#001f3f";
			"colors.statusbar.insert.fg" = "#ffffff";
			"colors.statusbar.insert.bg" = "#4b0082"; # Índigo profundo
			"colors.statusbar.command.fg" = "#e4b5ff";
			"colors.statusbar.command.bg" = "#001f3f";
			"colors.statusbar.url.fg" = "#e4b5ff";
			"colors.statusbar.url.success.http.fg" = "#7FDBFF";
			"colors.statusbar.url.success.https.fg" = "#ca89f0";
			"colors.statusbar.url.warn.fg" = "#f78400"; # Naranja de tu Hyprland border

			"colors.tabs.bar.bg" = "#001f3f";
			"colors.tabs.even.fg" = "#e4b5ff";
			"colors.tabs.even.bg" = "#001f3f";
			"colors.tabs.odd.fg" = "#e4b5ff";
			"colors.tabs.odd.bg" = "#001f3f";
			"colors.tabs.selected.even.fg" = "#ffffff";
			"colors.tabs.selected.even.bg" = "#b50cf7"; # Tu borde activo de Hyprland
			"colors.tabs.selected.odd.fg" = "#ffffff";
			"colors.tabs.selected.odd.bg" = "#b50cf7";
			"colors.tabs.indicator.start" = "#bf00ff";
			"colors.tabs.indicator.stop" = "#ca89f0";

			"colors.messages.error.bg" = "#bf00ff";
			"colors.messages.info.bg" = "#001f3f";
			"colors.messages.warning.bg" = "#f78400";
			
			"colors.prompts.fg" = "#e4b5ff";
			"colors.prompts.bg" = "#001f3f";
			"colors.prompts.selected.bg" = "#ca89f0";
    };

    # Atajos rápidos para tus herramientas diarias
    aliases = {
      "gdrive" = "open -t https://drive.google.com";
      "gdocs" = "open -t https://docs.google.com";
      "gmeet" = "open -t https://meet.google.com";
    };

    # Keybindings específicos
    keyBindings = {
      normal = {
        ",m" = "spawn mpv {url}"; # Abrir video actual en MPV
        ",p" = "config-cycle content.proxy system none"; # Toggle proxy si lo usas
      };
    };

    extraConfig = ''
      # Configuración específica por dominio (Python puro)
      # Esto asegura que el User Agent de Google solo se aplique donde es necesario
      config.set('content.headers.user_agent', 'Mozilla/5.0 (X11; Linux x86_64; rv:133.0) Gecko/20100101 Firefox/133.0', 'https://accounts.google.com/*')
    '';
  };
}
