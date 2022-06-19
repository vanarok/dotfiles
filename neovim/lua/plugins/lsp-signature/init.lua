local config = require('core.user')
local u = require('utils')

require('lsp_signature').setup(u.merge({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = config.border,
  },
}, config.lsp_signature or {}))
