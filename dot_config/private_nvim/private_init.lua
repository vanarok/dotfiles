local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "neovim/nvim-lspconfig" },
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').setup({
				extensions = {
					fzf = {
						fuzzy = true,                   
						override_generic_sorter = true,  
						override_file_sorter = true,  
						case_mode = "smart_case",        
					},
				}
			})
			require('telescope').load_extension('fzf')
		end
	},		
	{ 
		"catppuccin/nvim", name = "catppuccin", priority = 1000, 
		config = function() 
			require("catppuccin").setup({
				flavour = "latte", 
				no_italic = "true",
				integrations = {
	        cmp = true,
	        gitsigns = true,
	        nvimtree = true,
	        treesitter = true,
	        notify = false,
	        mini = {
	            enabled = true,
	            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
			})
		end
	},

	{
	  'projekt0n/github-nvim-theme',
	  lazy = false, -- make sure we load this during startup if it is your main colorscheme
	  priority = 1000, -- make sure to load this before all the other start plugins
	  config = function()
	    require('github-theme').setup({
	      -- ...
	    })

	  end,
	},

 {
	  'Exafunction/codeium.vim',
  	event = 'BufEnter',
	  config = function ()
	    -- Change '<C-g>' here to any keycode you like.
	    vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
	    vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
	    vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
	    vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
	  end
	},
	{
	  "nvim-treesitter/nvim-treesitter",
	  version = false, -- last release is way too old and doesn't work on Windows
	  build = ":TSUpdate",
	  dependencies = {
	    {
	      "nvim-treesitter/nvim-treesitter-textobjects",
	      config = function()
	        -- When in diff mode, we want to use the default
	        -- vim text objects c & C instead of the treesitter ones.
	        local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
	        local configs = require("nvim-treesitter.configs")
	        for name, fn in pairs(move) do
	          if name:find("goto") == 1 then
	            move[name] = function(q, ...)
	              if vim.wo.diff then
	                local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
	                for key, query in pairs(config or {}) do
	                  if q == query and key:find("[%]%[][cC]") then
	                    vim.cmd("normal! " .. key)
	                    return
	                  end
	                end
	              end
	              return fn(q, ...)
	            end
	          end
	        end
	      end,
	    },
	  },
	  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	  opts = {
	    highlight = { enable = true },
	    indent = { enable = true },
	    ensure_installed = {
	      "bash",
	      "c",
	      "diff",
	      "html",
	      "javascript",
	      "jsdoc",
	      "json",
	      "jsonc",
	      "lua",
	      "luadoc",
	      "luap",
	      "markdown",
	      "markdown_inline",
	      "python",
	      "query",
	      "regex",
	      "toml",
	      "tsx",
	      "typescript",
	      "vim",
	      "vimdoc",
	      "yaml",
				"vue",
	    },
	    textobjects = {
	      move = {
	        enable = true,
	        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
	        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
	        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
	        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
	      },
	    },
	  },
	  config = function(_, opts)
	    if type(opts.ensure_installed) == "table" then
	      ---@type table<string, boolean>
	      local added = {}
	      opts.ensure_installed = vim.tbl_filter(function(lang)
	        if added[lang] then
	          return false
	        end
	        added[lang] = true
	        return true
	      end, opts.ensure_installed)
	    end
	    require("nvim-treesitter.configs").setup(opts)
	  end,
	}
})

vim.cmd('colorscheme github_light')
vim.g.mapleader = " " 

local map = vim.api.nvim_set_keymap
local defaults = { noremap = true, silent = true }
map("i", "zr", "<esc>l", defaults)

vim.bo.shiftwidth = 3
vim.bo.tabstop = 3

-- Telescope shortcuts
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    float = {
        border = "single",
        format = function(diagnostic)
            return string.format(
                "%s (%s) [%s]",
                diagnostic.message,
                diagnostic.source,
                diagnostic.code or diagnostic.user_data.lsp.code
            )
        end,
    },
})


-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {}
lspconfig.volar.setup {
	filetypes = { 'typescript', 'javascript', 'vue' },
  init_options = {
		typescript = {
			tsdk = '/data/data/com.termux/files/home/.local/share/pnpm/global/5/node_modules/typescript/lib',
		}
	}
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
