local config = {
  -- See https://github.com/rmagatti/auto-session#%EF%B8%8F-configuration
  auto_session = {
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_suppress_dirs = { '~/', '~/Projects' },
  },
  -- See :h nvim_open_win for possible border options
  border = 'rounded',
  max_width = '100',
  -- https://github.com/numToStr/Comment.nvim#configuration-optional
  -- comment_nvim = {},
  -- See https://github.com/CosmicNvim/cosmic-ui#%EF%B8%8F-configuration
  -- cosmic_ui = {},
  -- See :h vim.diagnostic.config for all diagnostic configuration options
  diagnostic = {
    virtual_text = false,
  },
  -- See :h gitsigns-usage
  -- gitsigns = {},
  -- LSP settings
  lsp = {
    -- True/false or table of filetypes {'.ts', '.js',}
    format_on_save = { '*.ts', '*.json', '*.js', '*.cjs', '*.vue', '*.html', '*.lua', '*.md', '*.toml' },
    -- Time in MS before format timeout
    format_timeout = 3000,
    -- Set to false to disable rename notification
    rename_notification = true,
    -- Enable non-default servers, use default lsp config
    -- Check here for configs that will be used by default: https://github.com/williamboman/nvim-lsp-installer/tree/main/lua/nvim-lsp-installer/servers
    servers = {
      rust_analyzer = false,
      jsonls = {
        format = false,
      },
      pyright = true,
      sumneko_lua = {
        format = false,
      },
      html = {
        format = false,
      },
      volar = {
        format = false,
        opts = {},
      },
      -- Enable tsserver w/custom settings
      tsserver = {
        format = false,
        opts = {
          on_attach = function(client, bufnr) end,
          flags = {
            debounce_text_changes = 150,
          },
        },
      },
    },
    -- See Cosmic defaults lsp/providers/tsserver.lua
    -- ts_utils = {},
  },
  -- See https://github.com/ray-x/lsp_signature.nvim#full-configuration-with-default-values
  -- lsp_signature = {},
  -- See https://github.com/L3MON4D3/LuaSnip/blob/577045e9adf325e58f690f4d4b4a293f3dcec1b3/README.md#config
  -- luasnip = {},
  -- Default statusline icon
  statusline = {
    main_icon = '🐱',
  },
  -- See :h telescope.setup
  -- telescope = {},
  theme = 'github',
  theme_options = {
    dev = true,
    theme_style = 'light',
    keyword_style = 'italic',
    function_style = 'none',
    variable_style = 'none',
    dark_float = false,
    dark_sidebar = true,
  },
  -- See https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
  -- todo_comments = {},
  -- See :h nvim-treesitter-quickstart
  -- treesitter = {},
  -- See :h notify.setup
  -- notify = {},
  -- See :h cmp-usage
  nvim_cmp = {
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
      { name = 'buffer', max_item_count = 7 },
      { name = 'path' },
    },
  },
}

return config
