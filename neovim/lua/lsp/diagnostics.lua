local u = require('utils')
local icons = require('theme.icons')
local config = require('core.user')

-- set up LSP signs
local signs = {
    Error = icons.error .. ' ',
    Warn = icons.warn .. ' ',
    Hint = icons.hint .. ' ',
    Info = icons.info .. ' ',
}

for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- set up vim.diagnostics
-- vim.diagnostic.config opts
vim.diagnostic.config(u.merge({
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = config.border,
        focusable = true,
        header = { icons.debug .. ' Diagnostics:', 'Normal' },
        source = 'always',
    },
    virtual_text = {
        spacing = 4,
        source = 'always',
        severity = {
            min = vim.diagnostic.severity.HINT,
        },
    },
}, config.diagnostic or {}))
