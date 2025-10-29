{ config, pkgs, MODULES_PATH, CONFILES_PATH, SCRIPTS_PATH, ... }:
{
	programs.wofi = {
	enable = true;
	};
}
