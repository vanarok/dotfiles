local augroup_name = 'CosmicNvimEditor'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
    command = [[%s/\s\+$//e]],
    group = group,
})
