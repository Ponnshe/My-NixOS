{ config, pkgs, ... }:
{
	programs.zellij = {
		enable = true;
		settings = {
		  theme = "dracula";
			show_startup_tips = false;
		};
	};
}
