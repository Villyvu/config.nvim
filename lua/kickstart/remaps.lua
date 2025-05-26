return {
  vim.keymap.set('n', '<A-j>', '<C-d>zz'),
  vim.keymap.set('n', '<A-k>', '<C-u>zz'),

  vim.keymap.set('n', 'ns', '<cmd>w<CR>', { desc = 'save curent buffer' }),
  vim.keymap.set('n', 'nw', '<cmd>wa<CR>', { desc = 'save all buffers?' }),
}
