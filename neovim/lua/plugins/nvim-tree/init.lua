local config = require('core.user')
local icons = require('theme.icons')
local u = require('utils')
local augroup_name = 'CosmicNvimNvimTree'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

-- set up args
local options = {
  disable_netrw = true,
  open_on_setup = true,
  open_on_setup_file = true,
  open_on_tab = true,
  respect_buf_cwd = true,
  update_cwd = true,
  reload_on_bufenter = true,
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
    centralize_selection = false,
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
}

-- Autoclose nvim is nvim-tree is only buffer open
vim.api.nvim_create_autocmd('BufEnter', {
  command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
  group = group,
  nested = true,
})

require('nvim-tree').setup(u.merge(options, config.nvim_tree or {}))
