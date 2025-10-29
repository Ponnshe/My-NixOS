-- Atajos
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<C-x><C-s>', '<Esc>:w<CR>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Mostrar error bajo cursor" })
