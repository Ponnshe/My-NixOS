{ config, pkgs, ... }:
{
  programs.aria2 = {
    enable = true;
		systemd.enable = true;
		settings = {
			# Optimización de red
			"max-connection-per-server" = 16;
			"split" = 16;
			"min-split-size" = "1M";
			"max-concurrent-downloads" = 5;
			
			# Persistencia
			"continue" = true;
			"input-file" = "\${config.home.homeDirectory}/.config/aria2/aria2.session";
			"save-session" = "\${config.home.homeDirectory}/.config/aria2/aria2.session";
			"save-session-interval" = 60;

			# RPC para integración (necesario para aria2p)
			"enable-rpc" = true;
			"rpc-listen-all" = false; # Seguridad: solo localhost
			"rpc-allow-origin-all" = true;

			# Directorio por defecto (ajusta a tu estructura)
			"dir" = "\${config.home.homeDirectory}/Downloads";
		};
  };

  programs.aria2p = {
		enable = true;
	}
}
