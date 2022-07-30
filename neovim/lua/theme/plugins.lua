local M = {}

M.supported_themes = {
    'github',
}

function M.init(use, config)
    use({
        'projekt0n/github-nvim-theme',
        as = 'github',
        config = function()
            require('github-theme').setup(require('core.user').theme_options)
            vim.cmd('colorscheme github_light')
        end,
        disable = config.theme ~= 'github',
    })

    vim.cmd('colorscheme github_light')
end

return M
