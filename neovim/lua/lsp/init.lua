local config = require('core.user')

-- set up lsp servers
require('lsp.providers')
require('lsp.diagnostics')
require('lsp.commands')

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = config.border,
  max_width = config.max_width,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = config.border,
  max_width = config.max_width,
})
