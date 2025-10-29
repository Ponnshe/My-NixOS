return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local root_dir = require('jdtls.setup').find_root({'.git', 'pom.xml', 'build.gradle'})
      if not root_dir then
        vim.notify("No se encontró la raíz del proyecto Java", vim.log.levels.WARN)
        return
      end

      local home = os.getenv("HOME")
      local project_name = vim.fn.fnamemodify(root_dir, ":t")
      local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

      local config = {
        cmd = { "jdtls", "-data", workspace_dir },
        root_dir = root_dir,
        capabilities = capabilities,
        settings = {
          java = {
            signatureHelp = { enabled = true },
            completion = {
              favoriteStaticMembers = { "org.junit.jupiter.api.Assertions.*" },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
}
