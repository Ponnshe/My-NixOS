return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" }, -- 👈 esto carga treesitter al abrir archivos
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"python",
				"html",
				"css",
				"javascript",
				"nix",
				"clojure",
				"sql"
				-- Agrega aquí los lenguajes que realmente usás
			},
			highlight = {
				enable = true,
			},
		},
	}
}
