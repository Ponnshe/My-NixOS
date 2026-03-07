-- ==========================================
-- init.lua para NixOS/Home Manager con Lazy
-- ==========================================

-- 1. Ajustar package.path para que Lua encuentre tus módulos
local confiles_lua_path = "/home/ponnshe/nixos-config/home/modules/confiles/nvim/lua/?.lua;" ..
                           "/home/ponnshe/nixos-config/home/modules/confiles/nvim/lua/?/init.lua;" ..
                           package.path
package.path = confiles_lua_path

-- 2. Ajustar runtimepath para Lazy.nvim y tu confiles
local lazy_path = vim.fn.expand("~/.config/nvim/lazy/lazy.nvim")
vim.opt.runtimepath:prepend(lazy_path)
vim.opt.runtimepath:prepend("/home/ponnshe/nixos-config/home/modules/confiles/nvim")

-- 3. Variables de líderes
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 4. Configuración general
require("config.general_conf")
require("config.keymaps")

-- 5. Cargar Lazy.nvim con tu carpeta de plugins
require("lazy").setup("plugins", {
    install_path = vim.fn.stdpath("data") .. "/lazy",  -- normalmente ~/.local/share/nvim/lazy
		rocks = {
			enabled = false,
			hererocks = false,
		},
})

-- 6. Mensaje opcional si extra_rtp no está configurado
local extra_rtp = os.getenv("NVIM_EXTRA_RTP")
if not extra_rtp then
  vim.notify("Warning: NVIM_EXTRA_RTP not set", vim.log.levels.WARN)
end
