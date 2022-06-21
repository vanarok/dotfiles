local config = require('core.user')
local icons = require('theme.icons')
local u = require('utils')

require('notify').setup(u.merge({
    icons = {
        ERROR = icons.error,
        WARN = icons.warn,
        INFO = icons.info,
        DEBUG = icons.debug,
        TRACE = icons.trace,
    },
    stages = 'slide',
    background_colour = require('theme.colors').bg,
}, config.notify or {}))

vim.notify = require('notify')

require('plugins.notify.highlights')
