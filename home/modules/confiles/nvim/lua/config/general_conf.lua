-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.syntax = "on"
vim.opt.updatetime = 100

-- Indentation config
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Configuración básica para mostrar diagnósticos como virtual text mientras editas
vim.diagnostic.config({
  virtual_text = true;
  signs = true,           -- Mostrar símbolos en la gutter (barra lateral)
  update_in_insert = true, -- Actualizar diagnósticos mientras escribes
  underline = true,       -- Subrayar los errores en el código
  severity_sort = true,   -- Ordenar diagnósticos por severidad
  float = {
    border = 'rounded',   -- Borde redondeado en ventanas flotantes
  },
})


-- Activate cursorline
vim.wo.cursorline = true

vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

-- Make cursorline underline
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("hi clear CursorLine")
    vim.cmd("hi CursorLine gui=underline cterm=underline")
  end,
})

