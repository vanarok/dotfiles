local dap = require('dap')
dap.adapters['pwa-node'] = require('dap.dap-js').connect

-- dap.set_log_level("TRACE")

-- https://code.visualstudio.com/docs/nodejs/nodejs-debugging#_launch-configuration-attributes
dap.configurations.typescript = {
    {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
    },
    {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
    },
}
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.api.nvim_command("au FileType dap-repl lua require('dap.ext.autocompl').attach()")

dap.listeners.before['event_loadedSource']['cosmic'] = function(--[[ _session, _body ]])
    -- ignore
end

local load_launchjs = function()
    require('dap.ext.vscode').load_launchjs()
end
if not pcall(load_launchjs) then
    vim.notify('Failed to parse launch.json', 'warn')
end
