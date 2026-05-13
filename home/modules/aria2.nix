{ config, pkgs, ... }:
{
  programs.aria2 = {
    enable = true;
		settings = {
			# Optimización de red
			"max-connection-per-server" = 16;
			"split" = 16;
			"min-split-size" = "1M";
			"max-concurrent-downloads" = 5;
			
			# Persistencia
			"continue" = true;
			"save-session" = "${config.home.homeDirectory}/.config/aria2/aria2.session";
			"save-session-interval" = 60;

			# Directorio por defecto (ajusta a tu estructura)
			"dir" = "${config.home.homeDirectory}/Downloads";
		};
  };
}
