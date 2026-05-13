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
		dillo-plus
		netsurf-browser
	];
}
