return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = {
      tools = {
        picker = "telescope",
      },
      server = {
        -- Keymaps buffer-local opcionales en on_attach
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            checkOnSave = diagnostics == "rust-analyzer",  -- corre Clippy al guardar
            diagnostics = { enable = diagnostics == "rust-analyzer"},       -- activa diagnostics en tiempo real
            procMacro = { enable = true },
            completion = { autoimport = { enable = true } },
            rustfmt = {
              command = "rustfmt",  -- el que viene del repositorio
              extraArgs = { "--edition", "2021" },
            },
            files = {
              excludeDirs = {
                ".direnv", ".git", ".github", ".gitlab", "bin",
                "node_modules", "target", "venv", ".venv",
              },
							watcher = "client",
            },
          },
				},
			},
		},
      config = function(_, opts)
        -- Configura DAP si está codelldb
        local ok, registry = pcall(require, "mason-registry")
        if ok and registry.has_package("codelldb") then
          local path = registry.get_package("codelldb"):get_install_path()
          local codelldb = path .. "/extension/adapter/codelldb"
          local lib = path .. "/extension/lldb/lib/liblldb.so"
          if vim.loop.os_uname().sysname == "Darwin" then
            lib = path .. "/extension/lldb/lib/liblldb.dylib"
          end
          opts.dap = {
            adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, lib),
          }
        end
        vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
        if vim.fn.executable("rust-analyzer") == 0 then
          vim.notify("rust-analyzer no está en PATH (instalalo vía Nix, no con Mason).", vim.log.levels.WARN)
        end
      end,
      keys = {
        -- Rust LSP actions
        { "K",          function() vim.cmd.RustLsp({ "hover", "actions" }) end, ft = "rust", desc = "Rust: Hover Actions" },
        { "<leader>cR", function() vim.cmd.RustLsp("codeAction")           end, ft = "rust", desc = "Rust: Code Action" },
        { "<leader>rR", function() vim.cmd.RustLsp("runnables")           end, ft = "rust", desc = "Rust: Runnables (cargo)" },
        { "<leader>rr", function() vim.cmd.RustLsp("run")                  end, ft = "rust", desc = "Rust: Run objective under cursor" },
        { "<leader>rt", function() vim.cmd.RustLsp("testables")           end, ft = "rust", desc = "Rust: Tests" },
        { "<leader>dr", function() vim.cmd.RustLsp("debuggables")         end, ft = "rust", desc = "Rust: Debuggables (DAP)" },
        { "<leader>re", function() vim.cmd.RustLsp("expandMacro")         end, ft = "rust", desc = "Rust: Expand Macro" },
        { "<leader><C-k>", function() vim.cmd.RustLsp("moveItem up")     end, ft = "rust", desc = "Rust: Move Item Up" },
        { "<leader><C-j>", function() vim.cmd.RustLsp("moveItem down")   end, ft = "rust", desc = "Rust: Move Item Down" },
        { "<leader>oM",   function() vim.cmd.RustLsp("parentModule")    end, ft = "rust", desc = "Rust: Open Parent mod.rs" },

        -- LSP estándar
        { "gd", function() vim.lsp.buf.definition() end, ft = "rust", desc = "Go to definition" },
        { "gD", function() vim.lsp.buf.declaration() end, ft = "rust", desc = "Go to declaration" },
        { "gr", function() vim.lsp.buf.references() end, ft = "rust", desc = "References" },
        { "gi", function() vim.lsp.buf.implementation() end, ft = "rust", desc = "Implementation" },
      },
    },
  -- Asegurate de que lspconfig NO configure rust_analyzer (lo hace rustaceanvim)
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { rust_analyzer = { enabled = false } } },
  },
}
