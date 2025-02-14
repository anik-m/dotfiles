return { -- Return a table of plugin specifications

  {
    'dccsillag/magma-nvim',
    run = ':UpdateRemotePlugins',
    config = function()
      -- require('magma').setup {
      --   -- Your Magma configuration (moved to magma.lua)
      --   magma_vim_options = require 'magma', -- Load configuration from magma.lua
      -- }
    end,
    -- Other lazy.nvim options for magma-nvim if needed
  },

  -- ... other plugins ...
}
