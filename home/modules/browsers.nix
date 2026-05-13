{ config, pkgs, ... }:

{
	programs = {
		nyxt = {
			enable = true;
		};

		w3m = {
			enable = true;
		};
	};

	home.packages = with pkgs; [
		surf
		dillo
		dillo-plus
		netsurf-browser
	];
}
