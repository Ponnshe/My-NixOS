return {
  {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
			vim.g.molten_output_win_style = "minimal"  -- Estilo flotante
			vim.g.molten_virt_text_output = false       -- Desactiva el texto virtual (que es el que desaparece)
			vim.g.molten_use_border_highlights = true
      
			-- Atajos de Molten (Manejo del Kernel)
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Init Molten" })
      vim.keymap.set("n", "<leader>rh", ":MoltenHideOutput<CR>", { desc = "Ocultar output" })
      vim.keymap.set("n", "<leader>rs", ":MoltenShowOutput<CR>", { desc = "Mostrar output" })
    end,
  },

  -- Image.nvim: Para que dejes de ver solo texto
  {
    "3rd/image.nvim",
    opts = {
      backend = "sixel",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki", "quarto" },
        },
      },
      max_width = 100,
      max_height = 12,
      window_overlap_clear_enabled = true,
    },
  },

  -- Quarto: Para manejar notebooks y archivos .qmd
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        languages = { "python" },
        chunks = "all",
        diagnostics = { enabled = true },
        completion = { enabled = true },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)
			vim.keymap.set("n", "<leader>ra", ":QuartoSendAll<CR>", { desc = "Ejecutar todo" })
      vim.keymap.set("n", "<leader>rc", ":QuartoSend<CR>", { desc = "Ejecutar celda actual" })
    end,
  },

  -- Otter: Autocompletado dentro de los bloques de código
  {
    "jmbuhr/otter.nvim",
    dependencies = { "nvim-lspconfig" },
    opts = {},
  },
}
