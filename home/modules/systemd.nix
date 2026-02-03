{ config, pkgs, scriptsPath, ... }:
{
	systemd.user = {
		enable = true;
		services = {
			battery-lock = {
				Unit = {
					Description = "Battery lock daemon";
					After = [ "graphical-session.target" ];
				};

				Service = {
					ExecStart = "${pkgs.bash}/bin/bash ${scriptsPath}/utils/bat_lock.sh";
					Restart = "always";
					RestartSec = 10;
					Environment = "PATH=${pkgs.coreutils}/bin:${pkgs.util-linux}/bin:${pkgs.bash}/bin:${pkgs.libnotify}/bin:${pkgs.swaylock}/bin";
				};

				Install = {
					WantedBy = [ "default.target" ];
				};
			};
		};
	};
}
