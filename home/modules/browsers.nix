{ config, pkgs, ... }:

{
	programs = {
		nyxt = {
			enable = false;
		};

		w3m = {
			enable = true;
		};
	};

	home.packages = with pkgs; [
		dillo-plus
		netsurf-browser
	];
}
