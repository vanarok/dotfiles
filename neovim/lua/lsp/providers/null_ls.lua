local u = require('utils')
local defaults = require('lsp.providers.defaults')
local null_ls = require('null-ls')
local config = require('core.user')

local options = {
  default_cosmic_sources = false,
  fallback_severity = vim.diagnostic.severity.WARN,
  default_timeout = 60000,
  diagnostics_format = '[#{c}] #{m}',
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d.with({
      -- extra_filetypes = { 'json' },
    }),
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.prettierd.with({
      env = {
        PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
      },
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.codespell,
  },
}

require('null-ls').setup(u.merge(defaults, options))
