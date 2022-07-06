local user_config = require('core.user')

return {
  'wbthomason/packer.nvim',
  'lewis6991/impatient.nvim',
  'nathom/filetype.nvim',
  'nvim-lua/plenary.nvim',
  {
    'rcarriga/nvim-notify',
    config = function()
      require('plugins.notify')
    end,
    after = user_config.theme,
  },
  {
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('plugins.galaxyline')
    end,
    after = user_config.theme,
  },
  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('plugins.nvim-tree')
    end,
    cmd = {
      'NvimTreeClipboard',
      'NvimTreeClose',
      'NvimTreeFindFile',
      'NvimTreeOpen',
      'NvimTreeRefresh',
      'NvimTreeToggle',
    },
    event = 'VimEnter',
  },
  {
    'CosmicNvim/cosmic-ui',
    requires = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('plugins.cosmic-ui')
    end,
    event = 'BufWinEnter',
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lsp')
    end,
    requires = {
      { 'b0o/SchemaStore.nvim' },
      { 'williamboman/nvim-lsp-installer' },
      { 'jose-elias-alvarez/nvim-lsp-ts-utils' },
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require('lsp.providers.null_ls')
        end,
        after = 'nvim-lspconfig',
      },
      {
        'ray-x/lsp_signature.nvim',
        config = function()
          require('plugins.lsp-signature')
        end,
        after = 'nvim-lspconfig',
      },
    },
    event = 'BufWinEnter',
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.nvim-cmp')
    end,
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('plugins.luasnip')
        end,
        requires = {
          'sdras/vue-vscode-snippets',
          'rafamadriz/friendly-snippets',
        },
      },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      {
        'windwp/nvim-autopairs',
        config = function()
          require('plugins.auto-pairs')
        end,
        after = 'nvim-cmp',
      },
    },
    event = 'InsertEnter',
  },
  {
    'tpope/vim-fugitive',
    opt = true,
    cmd = 'Git',
  },
  {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    opt = true,
    event = 'BufWinEnter',
    config = function()
      require('plugins.gitsigns')
    end,
  },
  {
    'voldikss/vim-floaterm',
    opt = true,
    event = 'BufWinEnter',
    config = function()
      require('plugins.terminal')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
    },
    config = function()
      require('plugins.telescope.mappings').init()
      require('plugins.telescope')
    end,
    event = 'BufWinEnter',
  },
  {
    'glepnir/dashboard-nvim',
    config = function()
      require('plugins.dashboard')
    end,
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('plugins.auto-session')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    run = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('plugins.comments')
    end,
    event = 'BufWinEnter',
  },
  {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.todo-comments')
    end,
    event = 'BufWinEnter',
  },
  {
    'norcalli/nvim-colorizer.lua',
    opt = true,
    cmd = { 'ColorizerToggle' },
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    '~/Projects/bufferline.nvim',
    tag = 'v2.*',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('bufferline').setup({
        options = {
          numbers = 'ordinal',
          diagnostics_pure = true,
          diagnostics_indicator = function(count, level)
            if level == 'error' then
              return ' '
            end
          end,
          offsets = {
            { filetype = 'Trouble' },
            {
              filetype = 'NvimTree',
              text = 'פּ File Explorer',
              highlight = 'BufferLineFill',
              text_align = 'left',
            },
          },
          modified_icon = '',
          indicator_icon = false,
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = false,
          max_name_length = 30,
          tab_size = 8,
          diagnostics = 'nvim_lsp',
        },
        highlights = {
          buffer_selected = {
            gui = 'none',
          },
          diagnostic_selected = {
            gui = 'none',
          },
          info_selected = {
            gui = 'none',
          },
          info_diagnostic_selected = {
            gui = 'none',
          },
          warning_selected = {
            gui = 'none',
          },
          warning_diagnostic_selected = {
            gui = 'none',
          },
          error = {
            gui = 'undercurl',
          },
          error_selected = {
            gui = 'undercurl',
          },
          error_diagnostic_selected = {
            gui = 'none',
          },
          duplicate_selected = {
            gui = 'bold',
          },
          duplicate_visible = {
            gui = 'bold',
          },
          duplicate = {
            gui = 'bold',
          },
          pick_selected = {
            gui = 'none',
          },
          pick_visible = {
            gui = 'none',
          },
          pick = {
            gui = 'none',
          },
          numbers_selected = {
            gui = 'none',
          },
        },
      })
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.cmd([[highlight IndentBlanklineContextChar guibg=white]])
      vim.cmd([[highlight IndentBlanklineIndent1 guibg=#f5ffff gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent2 guibg=#fff5ff gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent3 guibg=#fffff5 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent4 guibg=#fff5f5 gui=nocombine]])
      vim.cmd([[highlight IndentBlanklineIndent5 guibg=#f5f5ff gui=nocombine]])
      require('indent_blankline').setup({
        char = '',
        char_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
        },
        space_char_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
        },
        context_char = '│',
        show_trailing_blankline_indent = false,
        space_char_blankline = ' ',
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
  'takac/vim-hardtime',
  'ggandor/lightspeed.nvim',
  'wakatime/vim-wakatime',
  'github/copilot.vim',
  {
    'yamatsum/nvim-nonicons',
    requires = { 'kyazdani42/nvim-web-devicons' },
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('dap')
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup({
        all_frames = true,
        commented = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
      })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    requires = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dapui').setup()
    end,
  },
  { 'microsoft/vscode-js-debug', opt = true, run = 'npm install && npm run-script compile' },
  {
    'vim-test/vim-test',
    requires = {
      { 'tpope/vim-dispatch' },
    },
  },
  {
    'rcarriga/vim-ultest',
    run = ':UpdateRemotePlugins',
    config = function()
      require('ultest').setup({
        builders = {
          ['typescript'] = require('dap.dap-js').ultest,
        },
      })
    end,
  },
  -- {
  --   'nvim-neotest/neotest',
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --     'antoinemadec/FixCursorHold.nvim',
  --   },
  -- },
  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup()
    end,
  },
  {
    'segeljakt/vim-silicon',
    cmd = 'Silicon',
    config = function()
      vim.g.silicon['output'] = '~/Pictures/code/silicon-{time:%Y-%m-%d-%H%M%S}.png'
    end,
  },
  {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('trouble').setup({
        auto_preview = false,
      })
    end,
  },
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({
        hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup({

        text = {
          spinner = 'pipe', -- animation shown when tasks are ongoing
          done = '✔', -- character shown when all tasks are complete
          commenced = 'Started', -- message shown when task starts
          completed = 'Completed', -- message shown when task completes
        },
        align = {
          bottom = true, -- align fidgets along bottom edge of buffer
          right = true, -- align fidgets along right edge of buffer
        },
        timer = {
          spinner_rate = 125, -- frame rate of spinner animation, in ms
          fidget_decay = 2000, -- how long to keep around empty fidget, in ms
          task_decay = 1000, -- how long to keep around completed task, in ms
        },
        window = {
          relative = 'win', -- where to anchor, either "win" or "editor"
          blend = 100, -- &winblend for the window
          zindex = nil, -- the zindex value for the window
        },
        fmt = {
          leftpad = true, -- right-justify text in fidget box
          stack_upwards = true, -- list of tasks grows upwards
          max_width = 0, -- maximum width of the fidget box
          -- function to format fidget title
          fidget = function(fidget_name, spinner)
            return string.format('%s %s', spinner, fidget_name)
          end,
          -- function to format each task line
          task = function(task_name, message, percentage)
            return string.format(
              '%s%s [%s]',
              message,
              percentage and string.format(' (%s%%)', percentage) or '',
              task_name
            )
          end,
        },
        sources = { -- Sources to configure
          ['null-ls'] = {
            ignore = true,
          },
        },
        debug = {
          logging = true, -- whether to enable logging, for debugging
          strict = false, -- whether to interpret LSP strictly
        },
      })
    end,
  },
  {
    'kosayoda/nvim-lightbulb',
    requires = 'antoinemadec/FixCursorHold.nvim',
    config = function()
      require('nvim-lightbulb').setup({ autocmd = { enabled = true }, ignore = { 'null-ls' } })
    end,
  },
}
