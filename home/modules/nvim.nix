{ config, pkgs, MODULES_PATH, CONFILES_PATH, lib, ... }:

{
	home.sessionVariables = {
    NVIM_EXTRA_RTP = "${CONFILES_PATH}/nvim";
  };

	home.activation.lazy-nvim = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
		echo "===> Ejecutando hook lazy-nvim"
		mkdir -p ~/.config/nvim/lazy
		if [ ! -d ~/.config/nvim/lazy/lazy.nvim ]; then
			echo "===> Clonando lazy.nvim..."
			${pkgs.git}/bin/git clone https://github.com/folke/lazy.nvim.git ~/.config/nvim/lazy/lazy.nvim 2>&1
			cd ~/.config/nvim/lazy/lazy.nvim
			${pkgs.git}/bin/git checkout 6c3bda4aca61a13a9c63f1c1d1b16b9d3be90d7a 2>&1
		else
			echo "===> Ya existe lazy.nvim, omitiendo clone."
		fi
	'';

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

		extraLuaConfig = ''
			local lazy_path = vim.fn.expand("~/.config/nvim/lazy/lazy.nvim")
			vim.opt.rtp:prepend(lazy_path)
			vim.opt.runtimepath:prepend("${CONFILES_PATH}/nvim")
		'' + builtins.readFile "${CONFILES_PATH}/nvim/init.lua"; };
}
