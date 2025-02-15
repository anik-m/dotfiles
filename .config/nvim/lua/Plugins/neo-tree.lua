-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
  config = {
    popup_border_style = 'rounded',
    -- sources = {
    --   'filesystem',
    --   'buffers',
    -- },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_gitignored = false,
        hide_hidden = false,
        hide_dotfiles = false,
      },
      follow_current_file = { enabled = true },
    },
  },
}
