local map = require('utils').map
local g = vim.g
local opt = vim.opt
local o = vim.opt
local cmd = vim.cmd
local opts = { noremap = true, silent = true }

g.mapleader = ' '
g.hardtime_default_on = true
g.ultest_use_pty = 1
g.ultest_output_on_line = 0
o.background = 'light'

opt.title = true
opt.cmdheight = 0
opt.pumheight = 5
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.scrolloff = 15
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.fillchars = 'vert: ,eob: '
opt.guifont = 'JetBrains Mono:h10.5'
opt.guifontwide = 'Symbols Nerd Font:h15'
opt.list = true
opt.listchars = {}
opt.backspace = { 'eol', 'start', 'indent' }
opt.clipboard = 'unnamedplus'
opt.encoding = 'utf-8'
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.syntax = 'enable'
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*', '*/dist/*' }
opt.wildmenu = true
opt.cursorline = true
opt.laststatus = 3
opt.lazyredraw = true
opt.mouse = 'a'
opt.number = true
opt.rnu = true
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = 'yes'
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.wrap = false
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.shortmess = opt.shortmess + { c = true }
opt.redrawtime = 1500
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.termguicolors = true

cmd('filetype plugin indent on')
cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}')

-- fix diagnostic color on galaxyine
-- cmd('colorscheme github_light')

-- Common
map('n', '<leader><leader>hs', ':nohlsearch<cr>')
map('n', '<leader><leader>e', ':e ~/.config/nvim/lua/config/editor.lua<cr>', opts)
map('n', '<leader><leader>c', ':e ~/.config/nvim/lua/config/config.lua<cr>', opts)
map('n', '<leader><leader>k', ':e ~/.config/kitty/kitty.conf<cr>', opts)
map('n', '<leader>n', ':NvimTreeFocus<cr>', opts)

-- Improved clipboard
map('n', 'd', '"_d')
map('v', 'd', '"_d')
map('n', 'yy', '"+yy')
map('v', 'y', '"+y')
map('n', 'p', '"+p')
map('v', 'p', '"+p')
map('n', 'P', '"+P')
map('v', 'P', '"+P')
map('n', '<Return>', 'o<esc>')
map('n', '<S-Return>', '<S-o><esc>')

-- Bufferline
map('n', '<A-p>', ':BufferLineTogglePin<CR>', opts)
map('n', 'gp', ':BufferLinePick<CR>', opts)
map('n', 'gx', ':BufferLinePickClose<CR>', opts)
map('n', '<A-c>', ':BufferLineCloseLeft<CR>', opts)
map('n', '<A-w>', ':BufferLineCloseRight<CR>', opts)
map('n', '<A-1>', ':BufferLineGoToBuffer 1<CR>', opts)
map('n', '<A-2>', ':BufferLineGoToBuffer 2<CR>', opts)
map('n', '<A-2>', ':BufferLineGoToBuffer 2<CR>', opts)
map('n', '<A-3>', ':BufferLineGoToBuffer 3<CR>', opts)
map('n', '<A-4>', ':BufferLineGoToBuffer 4<CR>', opts)
map('n', '<A-5>', ':BufferLineGoToBuffer 5<CR>', opts)
map('n', '<A-6>', ':BufferLineGoToBuffer 6<CR>', opts)
map('n', '<A-7>', ':BufferLineGoToBuffer 7<CR>', opts)
map('n', '<A-8>', ':BufferLineGoToBuffer 8<CR>', opts)
map('n', '<A-9>', ':BufferLineGoToBuffer 9<CR>', opts)

-- Debug
map('n', '<Leader>dsc', ":lua require('dap').continue()<CR>")
map('n', '<Leader>dsv', ":lua require('dap').step_over()<CR>")
map('n', '<Leader>dsi', ":lua require('dap').step_into()<CR>")
map('n', '<Leader>dso', ":lua require('dap').step_out()<CR>")

map('n', '<Leader>dhh', ":lua require('dap.ui.variables').hover()<CR>")
map('v', '<Leader>dhv', ":lua require('dap.ui.variables').visual_hover()<CR>")

map('n', '<Leader>duh', ":lua require('dap.ui.widgets').hover()<CR>")
map('n', '<Leader>duf', ":lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>")

map('n', '<Leader>dro', ":lua require('dap').repl.open()<CR>")
map('n', '<Leader>drl', ":lua require('dap').repl.run_last()<CR>")

map('n', '<Leader>dbc', ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map('n', '<Leader>dbm', ":lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>")
map('n', '<Leader>dbt', ":lua require('dap').toggle_breakpoint()<CR>")

map('n', '<Leader>dc', ":lua require('dap.ui.variables').scopes()<CR>")
map('n', '<Leader>di', ":lua require('dapui').toggle()<CR>")
