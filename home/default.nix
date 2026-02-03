{ config, pkgs, lib, scriptsPath, myModulesPath, confilePath, ... }:
{
  home.username = "ponnshe";
  home.homeDirectory = "/home/ponnshe";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  home.packages = [ 
		pkgs.brave
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
		"${myModulesPath}/shell.nix"
		"${myModulesPath}/foot.nix"
		"${myModulesPath}/mpv.nix"
		"${myModulesPath}/nvim.nix"
		"${myModulesPath}/hyprland.nix"
		"${myModulesPath}/intellij.nix"
		"${myModulesPath}/sioyek.nix"
		"${myModulesPath}/yazi.nix"
		"${myModulesPath}/ripgrep.nix"
		"${myModulesPath}/fd.nix"
		"${myModulesPath}/ruff.nix"
		"${myModulesPath}/btop.nix"
		"${myModulesPath}/swaylock.nix"
		"${myModulesPath}/systemd.nix"
		"${myModulesPath}/wofi.nix"
		"${myModulesPath}/lazygit.nix"
		"${myModulesPath}/zellij.nix"
		"${myModulesPath}/qutebrowser.nix"
		"${myModulesPath}/obs-studio.nix"
		"${myModulesPath}/imv.nix"
		"${myModulesPath}/gemini-cli.nix"
		"${myModulesPath}/direnv.nix"
  ];

	home.sessionVariables = {
    # Variables de sesión limpias. 
    # LD_LIBRARY_PATH eliminado por seguridad.
	};

	home.sessionPath = [
		"${scriptsPath}/utils"
	];
	xdg.desktopEntries.anytype = {
    name = "Anytype";
    genericName = "Knowledge Base";
    # Aquí asegúrate de que la ruta sea correcta a donde está tu script
    exec = "${scriptsPath}/utils/run_extra_program.sh -appimg anytype";
    terminal = false;
    categories = [ "Office" "Utility" ];
    icon = "utilities-terminal"; # O la ruta a un icono png si lo descargas
  };

}
