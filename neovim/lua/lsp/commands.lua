local augroup_name = "CosmicNvimLspFormat"
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
local config = require("core.user")

if config.lsp.format_on_save then
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = config.lsp.format_on_save,
		callback = function()
			vim.lsp.buf.format({
				timeout_ms = config.lsp.format_timeout,
				-- check user config to see if we can format on save
				filter = function(client)
					if config.lsp.can_client_format(client.name) then
						return client.name
					end
				end,
			})
		end,
		group = group,
		nested = true,
	})
end
