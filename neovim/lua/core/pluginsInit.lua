local user_config = require('core.user')
local custom_packer = require('core.packer')
local packer = custom_packer.packer
local use = packer.use

return packer.startup(function()
    use({
        'wbthomason/packer.nvim',
        'lewis6991/impatient.nvim',
        'nathom/filetype.nvim',
        'nvim-lua/plenary.nvim',
    })

    -- initialize theme plugins
    require('theme.plugins').init(use, user_config)

    use({
        'rcarriga/nvim-notify',
        config = function()
            require('plugins.notify')
        end,
        after = user_config.theme,
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'notify'),
    })

    -- theme stuff
    use({ -- statusline
        'NTBBloodbath/galaxyline.nvim',
        branch = 'main',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('plugins.galaxyline')
        end,
        after = user_config.theme,
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'galaxyline'),
    })

    -- file explorer
    use({
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
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'nvim-tree'),
        event = 'VimEnter',
    })

    use({
        'CosmicNvim/cosmic-ui',
        requires = {
            'MunifTanjim/nui.nvim',
        },
        config = function()
            require('plugins.cosmic-ui')
        end,
        event = 'BufWinEnter',
    })

    use({
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
                disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'null-ls'),
                after = 'nvim-lspconfig',
            },
            {
                'ray-x/lsp_signature.nvim',
                config = function()
                    require('plugins.lsp-signature')
                end,
                after = 'nvim-lspconfig',
                disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'lsp_signature'),
            },
        },
        event = 'BufWinEnter',
    })

    -- autocompletion
    use({
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
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'nvim-cmp'),
    })

    -- git commands
    use({
        'tpope/vim-fugitive',
        opt = true,
        cmd = 'Git',
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'fugitive'),
    })

    -- git column signs
    use({
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        opt = true,
        event = 'BufWinEnter',
        config = function()
            require('plugins.gitsigns')
        end,
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'gitsigns'),
    })

    -- floating terminal
    use({
        'voldikss/vim-floaterm',
        opt = true,
        event = 'BufWinEnter',
        config = function()
            require('plugins.terminal')
        end,
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'terminal'),
    })

    -- file navigation
    use({
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
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'telescope'),
    })

    -- session/project management
    use({
        'glepnir/dashboard-nvim',
        config = function()
            require('plugins.dashboard')
        end,
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'dashboard'),
    })

    use({
        'rmagatti/auto-session',
        config = function()
            require('plugins.auto-session')
        end,
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'auto-session'),
    })

    -- lang/syntax stuff
    use({
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
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'treesitter'),
    })

    -- comments and stuff
    use({
        'numToStr/Comment.nvim',
        config = function()
            require('plugins.comments')
        end,
        event = 'BufWinEnter',
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'comment-nvim'),
    })

    -- todo highlights
    use({
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('plugins.todo-comments')
        end,
        event = 'BufWinEnter',
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'todo-comments'),
    })
    -- colorized hex codes
    use({
        'norcalli/nvim-colorizer.lua',
        opt = true,
        cmd = { 'ColorizerToggle' },
        config = function()
            require('colorizer').setup()
        end,
        disable = vim.tbl_contains(user_config.disable_builtin_plugins, 'colorizer'),
    })

    if user_config.add_plugins and not vim.tbl_isempty(user_config.add_plugins) then
        for _, plugin in pairs(user_config.add_plugins) do
            use(plugin)
        end
    end

    if custom_packer.first_install then
        packer.sync()
    end
end)
