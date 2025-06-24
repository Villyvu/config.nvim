return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('easy-dotnet').setup {
      test_runner = {
        viewmode = 'float',
      },
    }
    -- Keymaps
    local k = vim.keymap
    k.set('n', 'ær', '<cmd>Dotnet run<CR>', { desc = 'Run project' })
    k.set('n', 'æb', '<cmd>Dotnet build<CR>', { desc = 'Build project' })
    k.set('n', 'ætt', '<cmd>Dotnet testrunner<CR>', { desc = 'Testrunner' })
    k.set('n', 'ætb', '<cmd>Dotnet testrunner refresh build<CR>', { desc = 'Testrunner refresh build' })
    k.set('n', 'æwr', '<cmd>Dotnet watch<CR>', { desc = 'Watch run project' })
  end,
}
