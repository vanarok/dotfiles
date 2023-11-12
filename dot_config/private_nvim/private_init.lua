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
	{
		'chipsenkbeil/distant.nvim', 
		branch = 'v0.3',
		config = function()
			require('distant'):setup({    
				manager = {
					network = {
						unix_socket = '/data/data/com.termux/files/run/distant.socket'
					}
				},
				search = {
					paths = { '/home/frontend/test/gifki-rf' },
					pagination = 1,
					limit = 1
				},
				servers = {
					["*"] = {
						lsp = {
							['gifs.ru'] = {
								cmd = { '/usr/bin/vue-language-server' },
								filetypes = { 'vue' },
								root_dir = '/home/frontend/test/gifki-rf',
								typescript = {
									tsdk = '/usr/lib/node_modules/typescript/lib',
								}
							}
						},
						cwd = "/home/frontend/test/gifki-rf",
					}
				}
			})
		end
	},
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
					distant = {
						search = {
							paths = { '/home/frontend/test/gifki-rf' },
							pagination = 1,
							limit = 1
						}
					}
				}
			})
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('distant')
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
vim.keymap.set('n', '<leader>f', telescope.extensions.distant.search, {})
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
