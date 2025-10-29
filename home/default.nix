{ config, pkgs, lib, ... }:
let
  MODULES_PATH = ./modules;
  CONFILES_PATH = ./modules/confiles;
	SCRIPTS_PATH = ./scripts;

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
		allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		];
		permittedInsecurePackages = [
    ];
	};
  home.username = "ponnshe";
  home.homeDirectory = "/home/ponnshe";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  home.packages = [ 
		pkgs.opencv
		pkgs.git
    pkgs.home-manager 
    pkgs.nodejs
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-langservers-extracted # incluye HTML, CSS, JSON LSP
    pkgs.nodePackages.eslint
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.vlc
    pkgs.ffmpeg_6-full
    pkgs.droidcam
    pkgs.helvum
    pkgs.man-pages
		pkgs.postgresql
		pkgs.dbeaver-bin
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

		#Python
		pkgs.python3
		
		#Zotero
		pkgs.zotero

		pkgs.pandoc

		pkgs.mininet

		pkgs.python313Packages.weasyprint

		pkgs.pyright
		pkgs.valgrind

		pkgs.rust-analyzer
		pkgs.rustc
		pkgs.pkg-config

		pkgs.cmake
		pkgs.cargo
		pkgs.clang

		pkgs.llvmPackages.libclang.lib

		pkgs.vulkan-tools
		pkgs.vulkan-volk
		pkgs.libGL
		pkgs.mesa
		pkgs.rustfmt
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
		# Para Rust/LLVM
		LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";

		# Para Rust/Winit/Wayland
		LD_LIBRARY_PATH = "$HOME/.nix-profile/lib:/run/current-system/sw/lib";
	};

}
