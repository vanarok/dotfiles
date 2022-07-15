if vim.fn.has('nvim-0.8') == 0 then
  error('Need Neovim v0.8+ in order to run Cosmic!')
end

do
  local ok, _ = pcall(require, 'impatient')

  if not ok then
    vim.notify('impatient.nvim not installed', vim.log.levels.WARN)
  end
end

local mods = {
  'compiled',
  'core',
  'theme',
}

for _, mod in ipairs(mods) do
  local ok, err = pcall(require, mod)
  if mod == 'compiled' and not ok then
    vim.notify('Run :PackerCompile!', vim.log.levels.WARN, {
      title = 'CosmicNvim',
    })
  elseif not ok and not mod:find('core.user') then
    error(('Error loading %s...\n\n%s'):format(mod, err))
  end
end
