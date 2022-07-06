local user_config = require('core.user')
local plugins = require('config.plugins')
local custom_packer = require('core.packer')
local packer = custom_packer.packer
local use = packer.use

return packer.startup(function()
  require('theme.plugins').init(use, user_config)

  if plugins and not vim.tbl_isempty(plugins) then
    for _, plugin in pairs(plugins) do
      use(plugin)
    end
  end

  if custom_packer.first_install then
    packer.sync()
  end
end)
