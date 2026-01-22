{ config, pkgs, lib, ... }:
let
  MODULES_PATH = ./modules;
  CONFILES_PATH = ./modules/confiles; SCRIPTS_PATH = ./scripts;

	importWithArgs = name: extraArgs:
		import (MODULES_PATH + "/${name}.nix") (
			{
				inherit config pkgs MODULES_PATH CONFILES_PATH;
			} // extraArgs
		);

	importBasic = name:
    importWithArgs name {};

	importWithScripts = name:
    importWithArgs name {
      inherit SCRIPTS_PATH;
    };
in {
	nixpkgs.config = {
	  allowUnfree = true;
		permittedInsecurePackages = [
			"python-2.7.18.8"
    ];
	};
  home.username = "ponnshe";
  home.homeDirectory = "/home/ponnshe";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  home.packages = [ 
		pkgs.appimage-run
		pkgs.alsa-lib
		pkgs.opencv
		pkgs.git
    pkgs.home-manager 
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.vlc
    pkgs.ffmpeg_6-full
    pkgs.droidcam
    pkgs.helvum
    pkgs.man-pages
		pkgs.wkhtmltopdf
    pkgs.nodePackages.mermaid-cli
		pkgs.lsd
		pkgs.tectonic

		pkgs.libxkbcommon
		pkgs.wayland
		pkgs.wayland-protocols
		pkgs.wlroots

		pkgs.xorg.libX11
		pkgs.xorg.libXcursor
		pkgs.xorg.libXrandr

		pkgs.xorg.libXi

		# Nix-prefetc
		pkgs.nix-prefetch
		pkgs.nix-prefetch-github

		pkgs.pandoc
    # Algunos paquetes útiles globalmente para scripts rápidos, aunque idealmente deberían ir en flakes
    pkgs.jq
    pkgs.ripgrep
    pkgs.fd

		pkgs.zotero
  ]; 

  imports = [
    (importWithScripts "shell")
    (importBasic "foot")
		(importWithArgs "nvim" { inherit lib; })
    (importWithScripts "hyprland")
    (importBasic "intellij")
    (importBasic "sioyek")
    (importBasic "yazi")
    (importBasic "ripgrep")
    (importBasic "fd")
		(importBasic "ruff")
		(importBasic "btop")
		(importBasic "swaylock")
		(importWithScripts "systemd")
		(importWithScripts "wofi")
		(importBasic "lazygit")
		(importBasic "zellij")
  ];

	home.sessionVariables = {
    # Variables de sesión limpias. 
    # LD_LIBRARY_PATH eliminado por seguridad.
	};

}
