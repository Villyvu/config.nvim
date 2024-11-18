return {
  vim.keymap.set('n', '<A-j>', '<C-d>zz'),
  vim.keymap.set('n', '<A-k>', '<C-u>zz'),
  vim.api.nvim_set_keymap('n', '<A-o>', '/{<CR><Esc>o', { noremap = true, silent = true }),
}
