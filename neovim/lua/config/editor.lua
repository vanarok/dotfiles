local map = require('utils').map
local g = vim.g
local opt = vim.opt
local o = vim.opt
local cmd = vim.cmd
local opts = { noremap = true, silent = true }

local indent = 2
g.mapleader = ' '
g.ultest_deprecation_notice = 0
g.neovide_transparency = 0.7

-- plugins
g.hardtime_default_on = true
g.ultest_use_pty = 1
g.ultest_output_on_line = 0

-- misc
opt.backspace = { 'eol', 'start', 'indent' }
opt.clipboard = 'unnamedplus'
opt.encoding = 'utf-8'
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.syntax = 'enable'

-- indentation
opt.cmdheight = 0
opt.pumheight = 7
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

-- search
opt.incsearch = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*', '*/dist/*' }
opt.wildmenu = true

-- ui
opt.fillchars = 'eob: ,horiz: ,horizup: ,horizdown: ,vert: ,vertleft: ,vertright: ,verthoriz: '
opt.title = true
-- opt.guifont = 'JetBrains Mono Light,Symbols Nerd Font:h12'
opt.guifont = 'JetBrains Mono:h13'
opt.guifontwide = 'Symbols Nerd Font:h15'
opt.cursorline = false
opt.laststatus = 3
opt.lazyredraw = true
opt.list = false
opt.listchars = {
  tab = '❘-',
  trail = '·',
  lead = '·',
  extends = '»',
  precedes = '«',
  nbsp = '×',
}
opt.mouse = 'a'
opt.number = true
opt.rnu = true
opt.scrolloff = 18
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = 'yes'
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.wrap = false

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- autocomplete
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.shortmess = opt.shortmess + { c = true }

-- performance
opt.redrawtime = 1500
opt.timeoutlen = 500
cmd('au TextYankPost * silent! lua vim.highlight.on_yank {higroup="StatusLine", timeout=300}')
cmd('highlight FloatBorder guibg=red')
--
-- fix diagnostic color on galaxyine
cmd('colorscheme github_light')
cmd('autocmd TextChanged,FocusLost,BufEnter,InsertLeave * silent! update')

cmd([[highlight IndentBlanklineContextChar guibg=white guifg=#00b0ff gui=nocombine]])
cmd([[highlight IndentBlanklineContextStart gui=underline guisp=#00b0ff]])
cmd([[highlight CopilotSuggestion guifg=blue ctermfg=8]])

-- Common
map('n', '<leader>nh', ':nohlsearch<cr>')
map('n', '<leader><leader>e', ':e ~/.config/nvim/lua/config/editor.lua<cr>', opts)
map('n', '<leader><leader>c', ':e ~/.config/nvim/lua/config/config.lua<cr>', opts)
map('n', '<leader><leader>k', ':e ~/.config/kitty/kitty.conf<cr>', opts)
map('n', '<leader><leader>r', ':e [Rr][Ee][Aa][Dd][Mm][Ee].md<cr>', opts)
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
