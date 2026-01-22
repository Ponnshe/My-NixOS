return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Python
		vim.lsp.config('pyright',{
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
			}
		})

    -- C/C++
    vim.lsp.config('clangd', {
      capabilities = capabilities,
		})

    -- Web stack
    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
		})

    vim.lsp.config('html', {
      capabilities = capabilities,
		})

    vim.lsp.config('cssls', {
      capabilities = capabilities,
		})

    vim.lsp.config('eslint', {
      capabilities = capabilities,
		})

		vim.lsp.enable('pyright')
		vim.lsp.enable('clangd')
		vim.lsp.enable('ts_ls')
		vim.lsp.enable('html')
		vim.lsp.enable('cssls')
		vim.lsp.enable('eslint')
    -- Keymaps LSP
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition', buffer = 0 })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration', buffer = 0 })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation', buffer = 0 })
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, { desc = 'Hover documentation', buffer = 0 })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename', buffer = 0 })
    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer", buffer = 0 })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = 0 })

  end,
}
