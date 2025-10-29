return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ws", function() require('telescope.builtin').lsp_workspace_symbols() end, desc = "Workspace Symbols" },
      { 
        "<leader>bb", 
        function()
          local current_bufnr = vim.api.nvim_get_current_buf()
          local buffers = vim.fn.getbufinfo({buflisted = 1})
          local default_index = 1

          -- Buscar el índice del buffer actual para seleccionarlo por default
          for i, buf in ipairs(buffers) do
            if buf.bufnr == current_bufnr then
              default_index = i
              break
            end
          end

          require('telescope.builtin').buffers({
            sort_mru = true,                -- ordenar por último usado
            initial_mode = "normal",        -- modo normal al abrir
            default_selection_index = default_index,
          })
        end,
        desc = "List buffers (last used selected)"
      },
      { "<leader>td", function() require('telescope.builtin').diagnostics() end, desc = "Diagnostics" },
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find File" },
      { "<leader>km", "<cmd>Telescope keymaps<cr>", desc = "Find Keymaps" },
    },
    opts = {},
  },
}
