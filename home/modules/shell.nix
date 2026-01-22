{ config, pkgs, MODULES_PATH, CONFILES_PATH, SCRIPTS_PATH, ... }:
let
  MODULES_PATH = ./.;
  CONFILES_PATH = ./confiles;
  importBasic = name:
      import (MODULES_PATH + "/${name}.nix") {
        inherit config pkgs MODULES_PATH CONFILES_PATH;
      };
  importWithScripts= name:
      import (MODULES_PATH + "/${name}.nix") {
        inherit config pkgs MODULES_PATH CONFILES_PATH SCRIPTS_PATH;
      };
in 

{
  # Configuración global para los shells
  home.shell.enableShellIntegration = true;  # Habilita la integración global para todos los shells

  home.shellAliases = {
    cl = "clear";
    sync_notes = ". ~/scripts/sync_notes.sh";
    mkproj = ". ~/scripts/generate_project.sh";
    mk_clangd = ". ~/scripts/generate_clangd_file.sh";
    edit_config = "sudo -E nvim /etc/nixos";
		ls = "lsd";
		la = "lsd -la";
		anytype = "${SCRIPTS_PATH}/utils/run_extra_program.sh -appimg anytype";
  };

	home.sessionVariables = {
	  EDITOR = "nvim";
	};

  imports = [
    (importBasic "fzf")
    (importBasic "oh-my-posh")
    (importBasic "zoxide")
    (importBasic "direnv")
    (importWithScripts "zsh")
  ];
}
