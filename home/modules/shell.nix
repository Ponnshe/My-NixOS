{ config, pkgs, myModulesPath, scriptsPath, confilePath, ... }:
# We need all the imports for the imports for shell
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
		anytype = "${scriptsPath}/utils/run_extra_program.sh -appimg anytype";
  };

	home.sessionVariables = {
	  EDITOR = "nvim";
	};

  imports = [
    "${myModulesPath}/fzf.nix"
    "${myModulesPath}/oh-my-posh.nix"
    "${myModulesPath}/zoxide.nix"
    "${myModulesPath}/direnv.nix"
    "${myModulesPath}/zsh.nix"
  ];
}
