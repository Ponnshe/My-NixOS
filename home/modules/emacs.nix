{ pkgs, ... }:

let
  # Creamos un paquete que es solo un enlace al emacs original pero con el wrapper
  emacsWithBabelDeps = pkgs.symlinkJoin {
    name = "emacs-with-babel-deps";
    paths = [ pkgs.emacs30 ]; # O pkgs.emacs-pgtk si prefieres soporte nativo de Wayland
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
  };
in
{
  programs.emacs = {
    enable = true;
    package = emacsWithBabelDeps;
  };
}
