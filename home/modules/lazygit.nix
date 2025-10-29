{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
	programs.lazygit = {
		enable = true;
	};
}
