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
      projectile
      counsel-projectile
      org-roam
      org-roam-ui
			org-modern
      mermaid-mode
      ob-mermaid
			openwith
      ob-go
      ob-rust
      ob-typescript
			sudo-edit
      rustic
      doom-themes
      doom-modeline
      all-the-icons
      diredfl
      all-the-icons-dired
      dired-rainbow
      dired-preview
      which-key
      dashboard
      prettier
      visual-fill-column
      org-download
      citar
      bibtex-completion
      ivy-bibtex
      org-roam-bibtex
			rand-theme
			vterm
			plantuml-mode
			elfeed
			elfeed-org
    ];
  };

	services.emacs = {
    enable = true;
    client.enable = true;
		startWithUserSession = "graphical";
  };

	home.packages = with pkgs; [
    jre
    plantuml
    graphviz
    mermaid-cli
    sqlite
		cmake
		libtool
		libgcc
		(texlive.combined.scheme-medium.withPackages (ps: with ps; [
			dvipng
			dvisvgm
		]))
  ];

	home.file.".emacs.d" = {
    source = "${confilePath}/emacs";
    recursive = true;
  };

	home.file.".emacs.d/nix-env.el".text = 
let
  tex = pkgs.texlive.combined.scheme-medium;
in
	''
    ;; ARCHIVO AUTOGENERADO POR NIX - NO EDITAR A MANO
    ;; Inyecta dependencias puras en el entorno de Emacs sin contaminar el sistema

    (setenv "PATH" (concat "${pkgs.lib.makeBinPath [ 
      pkgs.jre 
      pkgs.plantuml 
      pkgs.graphviz 
      pkgs.mermaid-cli 
      pkgs.sqlite 
			tex
    ]}:" (getenv "PATH")))

    (setq exec-path (append '(
      "${pkgs.jre}/bin"
      "${pkgs.plantuml}/bin"
      "${pkgs.graphviz}/bin"
      "${pkgs.mermaid-cli}/bin"
      "${pkgs.sqlite}/bin"
			"${tex}/bin"
    ) exec-path))
  '';
}
