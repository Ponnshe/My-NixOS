-- A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
-- https://github.com/hrsh7th/nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- Fuente LSP
    "L3MON4D3/LuaSnip",         -- Snippets
    "saadparwaiz1/cmp_luasnip", -- Fuente para LuaSnip
    "rafamadriz/friendly-snippets", -- Colección de snippets
    "hrsh7th/cmp-buffer",
  },
	opts = function()
			local cmp = require("cmp")
			return {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			}
		end,
}
