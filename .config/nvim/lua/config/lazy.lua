local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end -- @diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- set <space> as the leader key
-- see `:help mapleader`
--  note: must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- set to true if you have a nerd font installed and selected in the terminal
vim.g.have_nerd_font = true

--LazyVim can stay lazy
vim.g.lazyvim_check_order = false

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

require('lazy').setup {
  spec = {
    -- import your plugins
    { import = 'Plugins' },
    { import = 'Themes' },
    { 'LunarVim/bigfile.nvim' },
    { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
    { 'godlygeek/tabular' }, -- format things as tables

    -- { 'EdenEast/nightfox.nvim' }, -- nightfox
    -- { import = 'Themes/tokyonight' },
    -- {
    --   'scottmckendry/cyberdream.nvim',
    --   lazy = false,
    --   priority = 1000,
    -- },
  },
  -- vim.cmd("colorscheme tokyonight")
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { 'cyberdream' } },
  -- -- automatically check for plugin updates
  checker = { enabled = true },
}
