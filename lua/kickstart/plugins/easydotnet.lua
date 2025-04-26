return {
  'GustavEikaas/easy-dotnet.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('easy-dotnet').setup()

    local cmp = require 'cmp'
    cmp.register_source('easy-dotnet', require('easy-dotnet').package_completion_source)

    local sources = cmp.config.sources {
      { name = 'nvim-lsp' },
      { name = 'easy-dotnet' },
    }

    local dotnet = require 'easy-dotnet'

    local state = {
      floating = {
        buf = -1,
        win = -1,
      },
    }
    local create_floating_window = function(opts)
      opts = opts or {}
      local width = opts.width or math.floor(vim.o.columns * 0.8)
      local height = opts.height or math.floor(vim.o.lines * 0.8)

      -- Calculate the position to center the window
      local col = math.floor((vim.o.columns - width) / 2)
      local row = math.floor((vim.o.lines - height) / 2)

      -- Create a buffer
      local buf = nil
      if type(opts.buf) == 'number' and vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
      else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
      end

      -- Define window configuration
      local win_config = {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal', -- No borders or extra UI elements
        border = 'rounded',
      }

      -- Create the floating window
      local win = vim.api.nvim_open_win(buf, true, win_config)

      return { buf = buf, win = win }
    end

    local toggle_terminal = function(opts)
      opts = {} or opts
      if opts.buf ~= nil then
        state.floating.buf = opts.buf
      end

      if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window { buf = state.floating.buf }
        -- if vim.bo[state.floating.buf].buftype ~= 'terminal' then
        --   vim.cmd.terminal()
        -- end
      else
        vim.api.nvim_win_hide(state.floating.win)
      end
      return { buf = state.floating.buf }
    end

    -- Example usage:
    -- Create a floating window with default dimensions
    vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})

    local terms = {
      test = -1,
      restore = -1,
      build = -1,
      run = -1,
    }

    dotnet.setup {

      ---@param action "test" | "restore" | "build" | "run"
      terminal = function(path, action, args)
        local commands = {
          run = function()
            return string.format('dotnet run --project %s %s', path, args)
          end,
          test = function()
            return string.format('dotnet test %s %s', path, args)
          end,
          restore = function()
            return string.format('dotnet restore %s %s', path, args)
          end,
          build = function()
            return string.format('dotnet build %s %s', path, args)
          end,
          watch = function()
            return string.format('dotnet watch --project %s %s', path, args)
          end,
        }
        local command = commands[action]() .. '\r'
        local floatingWindow = nil
        local curBuf = terms[action]
        if curBuf > -1 then
          floatingWindow = toggle_terminal { buf = curBuf }
        else
          floatingWindow = toggle_terminal()
          vim.cmd('term ' .. command)
          terms[action] = floatingWindow.buf
          print(terms[action])
        end
      end,
    }
    -- Keymaps
    local k = vim.keymap

    k.set('n', 'æ<TAB>', toggle_terminal, { desc = 'Run project' })
    k.set('n', 'ær', '<cmd>Dotnet run<CR>', { desc = 'Run project' })
    k.set('n', 'æb', '<cmd>Dotnet build<CR>', { desc = 'Build project' })
    k.set('n', 'æv', '<cmd>Dotnet project view<CR>', { desc = 'View project' })
    k.set('n', 'æea', '<cmd>Dotnet ef migrations add<CR>', { desc = 'EF Migrations add' })
    k.set('n', 'æeu', '<cmd>Dotnet ef migrations update<CR>', { desc = 'EF Migrations update' })
    k.set('n', 'æts', '<cmd>Dotnet testrunner<CR>', { desc = 'Testrunner' })
    k.set('n', 'ætr', '<cmd>Dotnet testrunner refresh<CR>', { desc = 'Testrunner refresh' })
    k.set('n', 'ætb', '<cmd>Dotnet testrunner refresh build<CR>', { desc = 'Testrunner refresh build' })
    k.set('n', 'æwr', '<cmd>Dotnet watch<CR>', { desc = 'Watch run project' })
  end,
}
