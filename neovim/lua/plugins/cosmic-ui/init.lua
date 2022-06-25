local config = require('core.user')
local u = require('utils')

local defaults = {
    border_style = config.border,
}

require('cosmic-ui').setup(u.merge(defaults, config.cosmic_ui or {}))
