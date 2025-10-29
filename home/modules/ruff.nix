# Este archivo configura la integración del linter y formateador para Python llamado Ruff, así como su servidor Language Server Protocol (LSP) para uso en editores compatibles (Neovim, VSCode, etc.) a través de Home Manager.
{ config, pkgs, MODULES_PATH, CONFILES_PATH, ... }:
{
	programs.ruff ={
		enable = true;  # activa Ruff CLI
		settings = {
			line-length = 100;
			per-file-ignores = { "__init__.py" = [ "F401" ]; };
			lint = {
				select = [ "E4" "E7" "E9" "F" ];
				ignore = [ ];
			};
		};
	};
}
