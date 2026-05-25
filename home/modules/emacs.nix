{ pkgs, confilePath, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      use-package
      quelpa
      quelpa-use-package
      general
      evil
      evil-collection
      ivy
      counsel
      swiper
      magit
      org-roam
      org-roam-ui
			org-modern
      mermaid-mode
      ob-mermaid
			openwith
      ob-go
      ob-rust
      ob-typescript
      rustic
      doom-themes
      doom-modeline
      all-the-icons
      which-key
      visual-fill-column
      org-download
      citar
      bibtex-completion
      ivy-bibtex
      org-roam-bibtex
			rand-theme
			plantuml-mode
			elfeed
			elfeed-org
			org-super-agenda
    ];
  };

	services.emacs = {
    enable = true;
    client.enable = true;
		startWithUserSession = "graphical";
  };

	home.packages = with pkgs; [
    plantuml
    graphviz

    mermaid-cli

    sqlite
  ];

	home.file.".emacs.d" = {
    source = "${confilePath}/emacs";
    recursive = true;
  };

	home.file.".emacs.d/nix-env.el".text = 
	let
		customTex = pkgs.texliveBasic.withPackages (ps: with ps; [
			dvipng
			dvisvgm
			geometry
			graphics
			collection-mathscience
			ulem
		]);
	in
	''
			;; ARCHIVO AUTOGENERADO POR NIX - NO EDITAR A MANO
			;; Inyecta dependencias puras en el entorno de Emacs sin contaminar el sistema

			(setenv "PATH" (concat "${pkgs.lib.makeBinPath [ 
				pkgs.plantuml 
				pkgs.graphviz 
				pkgs.mermaid-cli 
				pkgs.sqlite 
				customTex
			]}:" (getenv "PATH")))

			(setq exec-path (append '(
				"${pkgs.plantuml}/bin"
				"${pkgs.graphviz}/bin"
				"${pkgs.mermaid-cli}/bin"
				"${pkgs.sqlite}/bin"
				"${customTex}/bin"
			) exec-path))
		'';
}
