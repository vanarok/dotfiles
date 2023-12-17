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
	{ "navarasu/onedark.nvim", 
		config = function()
			require('onedark').load() 
			require('onedark').setup({ style = 'light' }) 
		end
	}
})

vim.g.mapleader = " " 

local map = vim.api.nvim_set_keymap
local defaults = { noremap = true, silent = true }
map("i", "zr", "<esc>l", defaults)

vim.bo.shiftwidth = 3
vim.bo.tabstop = 3

local builtin = require('telescope.builtin')
local telescope = require('telescope')
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
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
		['vue'] = {
				filetypes = { 'vue', 'ts', 'js' },
				typescript = {
					tsdk = '/usr/lib/node_modules/typescript/lib',
				}
		}
  },
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

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
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
