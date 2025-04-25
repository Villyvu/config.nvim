return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('easy-dotnet').setup()

    local cmp = require 'cmp'
    cmp.register_source('easy-dotnet', require('easy-dotnet').package_completion_source)

    sources = cmp.config.sources {
      { name = 'nvim-lsp' },
      { name = 'easy-dotnet' },
    }

    local dotnet = require 'easy-dotnet'

    -- Keymaps
    local k = vim.keymap
    k.set('n', '<leader>dr', '<cmd>Dotnet run<CR>', { desc = 'Run project' })
    k.set('n', '<leader>db', '<cmd>Dotnet build<CR>', { desc = 'Build project' })
    k.set('n', '<leader>dv', '<cmd>Dotnet project view<CR>', { desc = 'View project' })
    k.set('n', '<leader>dea', '<cmd>Dotnet ef migrations add<CR>', { desc = 'EF Migrations add' })
    k.set('n', '<leader>deu', '<cmd>Dotnet ef migrations update<CR>', { desc = 'EF Migrations update' })
    k.set('n', '<leader>dts', '<cmd>Dotnet testrunner<CR>', { desc = 'Testrunner' })
    k.set('n', '<leader>dtr', '<cmd>Dotnet testrunner refresh<CR>', { desc = 'Testrunner refresh' })
    k.set('n', '<leader>dtb', '<cmd>Dotnet testrunner refresh build<CR>', { desc = 'Testrunner refresh build' })
    k.set('n', '<leader>dwr', '<cmd>Dotnet watch<CR>', { desc = 'Watch run project' })
  end,
}
