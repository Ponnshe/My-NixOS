{ pkgs, ... }:

let
  # Tu wrapper actual para dependencias externas está bien
  emacsWithBabelDeps = pkgs.symlinkJoin {
    name = "emacs-with-babel-deps";
    paths = [ pkgs.emacs30 ]; 
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/emacs \
        --prefix PATH : ${pkgs.lib.makeBinPath [ 
          pkgs.jre 
          pkgs.plantuml 
          pkgs.graphviz 
          pkgs.mermaid-cli
        ]}
    '';
		meta = pkgs.emacs30.meta;
  };
in
{
  programs.emacs = {
    enable = true;
    package = emacsWithBabelDeps;
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
      mermaid-mode
      ob-mermaid
      ob-go
      ob-rust
      ob-typescript
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
      pdf-tools
      prettier
      visual-fill-column
      org-download
      org-notify
      citar
      bibtex-completion
      ivy-bibtex
      org-roam-bibtex
			rand-theme
    ];
  };
}
