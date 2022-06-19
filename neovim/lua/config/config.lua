local icons = require('theme.icons')
local null_ls = require('null-ls')

local config = {
    -- See https://github.com/rmagatti/auto-session#%EF%B8%8F-configuration
    auto_session = {
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = { '~/', '~/Projects' },
    },
    -- See :h nvim_open_win for possible border options
    border = 'single',
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
        format_on_save = true,
        -- Time in MS before format timeout
        format_timeout = 3000,
        -- Set to false to disable rename notification
        rename_notification = true,
        -- Enable non-default servers, use default lsp config
        -- Check here for configs that will be used by default: https://github.com/williamboman/nvim-lsp-installer/tree/main/lua/nvim-lsp-installer/servers
        servers = {
            -- Enable rust_analyzer
            rust_analyzer = false,

            -- Enable tsserver w/custom settings
            tsserver = {
                -- Disable formatting (defaults to true)
                format = true,
                -- OR add/override server options
                opts = {
                    on_attach = function(client, bufnr) end,
                    flags = {
                        debounce_text_changes = 150,
                    },
                },
            },
            -- See Cosmic defaults lsp/providers/null_ls.lua and https://github.com/jose-elias-alvarez/null-ls.nvim/
            -- If adding additional sources, be sure to also copy the defaults that you would like to preserve from lsp/providers/null_ls.lua
            null_ls = {
                default_cosmic_sources = false,
                sources = {
                    null_ls.builtins.code_actions.eslint_d,
                    null_ls.builtins.diagnostics.eslint_d.with({
                        extra_filetypes = { 'json' },
                    }),
                    null_ls.builtins.diagnostics.markdownlint,
                    null_ls.builtins.formatting.prettierd.with({
                        env = {
                            PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
                        },
                    }),
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.code_actions.gitsigns,
                    null_ls.builtins.diagnostics.codespell,
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
        theme_style = 'light',
        keyword_style = 'italic',
        function_style = 'none',
        variable_style = 'none',
        dev = true,
        overrides = function(c)
            return {
                DiagnosticHintInv = {
                    bg = c.red,
                    fg = c.red,
                },
            }
        end,
        dark_sidebar = false,
    },
    -- See https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
    -- todo_comments = {},
    -- See :h nvim-treesitter-quickstart
    -- treesitter = {},
    -- See :h notify.setup
    -- notify = {},
    -- See :h cmp-usage
    nvim_cmp = {
        sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'luasnip' },
            { name = 'buffer', max_item_count = 5 },
            { name = 'path' },
        },
    },
    nvim_tree = {
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        open_on_setup = true,
        open_on_setup_file = true,
        open_on_tab = true,
        respect_buf_cwd = true,
        update_cwd = true,
        diagnostics = {
            enable = false,
        },
        ignore_ft_on_setup = {
            'startify',
            'dashboard',
            'alpha',
        },
        filters = {
            dotfiles = false,
            custom = { '^\\.git$' },
        },
        update_focused_file = {
            enable = true,
        },
        view = {
            width = 45,
            number = false,
            relativenumber = false,
            hide_root_folder = true,
        },
        git = {
            enable = true,
            ignore = true,
            timeout = 500,
        },
        renderer = {
            highlight_git = true,
            special_files = {},
            icons = {
                glyphs = {
                    default = '',
                    symlink = icons.symlink,
                    git = icons.git,
                    folder = icons.folder,
                },
            },
            indent_markers = {
                enable = true,
                icons = {
                    corner = '└ ',
                    edge = '│ ',
                    item = '│ ',
                    none = '  ',
                },
            },
        },
    },
    -- Add additional plugins
    add_plugins = {
        {
            'akinsho/bufferline.nvim',
            tag = 'v2.*',
            requires = { 'kyazdani42/nvim-web-devicons' },
            config = function()
                require('bufferline').setup({
                    options = {
                        numbers = 'ordinal',
                        diagnostics_indicator = function(count, level)
                            if level == 'error' then
                                return ' ' .. count
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
            'editorconfig/editorconfig-vim',
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
    },
    {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup({})
        end,
    },
}

return config
