local extra_rtp = os.getenv("NVIM_EXTRA_RTP")
if extra_rtp then
  vim.opt.runtimepath:append(extra_rtp)
else
  vim.notify("Warning: NVIM_EXTRA_RTP not set", vim.log.levels.WARN)
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.general_conf")
require("config.keymaps")
-- require("config.lazy")
-- init.lua o config.lazy.lua
require("lazy").setup("plugins", {
  install_path = vim.fn.stdpath("data") .. "/lazy"  -- normalmente ~/.local/share/nvim/lazy
})
