local config = require('core.user')
local colors = require('github-theme.colors').setup({
    theme_style = config.theme_options.theme_style,
})

local colorsOptions = {
    white = colors.bright_white,
    bg = colors.bg,
    bg_highlight = colors.bg_highlight,
    normal = colors.blue,
    insert = colors.green,
    command = colors.bright_magenta,
    visual = colors.yellow,
    replace = colors.red,
    diffAdd = colors.git.add,
    diffModified = colors.git.change,
    diffDeleted = colors.git.delete,
    trace = colors.orange,
    hint = colors.hint,
    info = colors.info,
    error = colors.error,
    warn = colors.warning,
    floatBorder = colors.border,
    selection_caret = colors.magenta,
}

return colorsOptions 
