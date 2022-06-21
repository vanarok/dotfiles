local config = require('core.user')
local u = require('utils')

function _G.close_all_floating_wins()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local c = vim.api.nvim_win_get_config(win)
        if c.relative ~= '' then
            vim.api.nvim_win_close(win, false)
        end
    end
end

local defaults = {
    pre_save_cmds = { 'NvimTreeClose', 'cclose', 'lua vim.notify.dismiss()', _G.close_all_floating_wins },
    post_restore_cmds = { 'NvimTreeRefresh' },
    auto_session_enabled = false,
    auto_save_enabled = true,
    auto_restore_enabled = false,
}

require('auto-session').setup(u.merge(defaults, config.auto_session or {}))
