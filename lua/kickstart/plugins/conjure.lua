return {
  {
    'Olical/conjure',
    'tpope/vim-dispatch', -- kick off builds
    'radenling/vim-dispatch-neovim', -- add nvim terminal emulator and job control to dispatch.vim
    'clojure-vim/vim-jack-in', -- commands for clj, lein and boot
    ft = { 'clojure', 'fennel', 'python' }, -- etc
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
    end,

    -- Optional cmp-conjure integration
    dependencies = { 'PaterJason/cmp-conjure' },
  },
  {
    'PaterJason/cmp-conjure',
    lazy = true,
    config = function()
      local cmp = require 'cmp'
      local config = cmp.get_config()
      table.insert(config.sources, { name = 'conjure' })
      return cmp.setup(config)
    end,
  },
}
