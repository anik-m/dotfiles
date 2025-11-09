-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  -- ──────────────────────────────────────────────────────────────────────
  -- NeoTree – file explorer for Neovim
  -- ──────────────────────────────────────────────────────────────────────
  {
    'nvim-neo-tree/neo-tree.nvim',
    -- branch = "v3.x",                     -- latest stable branch
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- optional, but pretty icons
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree', -- lazy‑load only when :Neotree is called
    keys = {
      -- Open NeoTree on the left side
      { '\\', ':Neotree toggle left<CR>', desc = 'Toggle NeoTree' },
    },
    config = function()
      --------------------------------------------------------------------
      -- 1️⃣  Core NeoTree setup
      --------------------------------------------------------------------
      require('neo-tree').setup {
        close_if_last_window = false, -- don’t close nvim when the tree is the last win
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false,

        -- ─────────────────────────────────────────────────────────────────
        -- 2️⃣  Window behaviour
        -- ─────────────────────────────────────────────────────────────────
        filesystem = {
          filtered_items = {
            visible = false, -- hide .git etc. unless you explicitly show them
            hide_dotfiles = true,
            hide_gitignored = true,
          },

          -- *** DO NOT AUTO‑ENTER A FILE WHEN IT IS OPENED FROM the tree ***
          -- The default behaviour (`open_file_on_single_click = true`) jumps
          -- straight into the file.  Setting it to `false` keeps the cursor
          -- on the tree after the file is opened.
          open_file_on_single_click = false,

          -- If you *do* want the classic <Enter> to open the file **and**
          -- keep the tree open, set `keep_focus` to true.
          keep_focus = true,

          -- When you press <C-Enter> we want to *close* the tree first,
          -- then open the file in the current window.
          -- We'll map that in the `window.mappings` table below.
        },

        -- ─────────────────────────────────────────────────────────────────
        -- 3️⃣  Custom keybindings (the heart of the requested workflow)
        -- ─────────────────────────────────────────────────────────────────
        window = {
          position = 'left',
          width = 30,
          mappings = {
            -- Default behaviours (kept for reference)
            ['<cr>'] = 'open', -- <Enter> opens file, tree stays open
            ['<2-LeftMouse>'] = 'open', -- double‑click same as <Enter>

            -- *** NEW: Ctrl+Enter closes the tree then opens the file ***
            ['<c-cr>'] = function(state)
              -- 1️⃣ Close the NeoTree window
              local tree_win = state.winid
              vim.api.nvim_win_close(tree_win, true)

              -- 2️⃣ Open the node that was under the cursor
              local node = state.tree:get_node()
              if node then
                require('neo-tree.sources.filesystem').open(state, node)
              end
            end,

            -- Optional convenience: <Esc> just closes the tree
            -- ['<esc>'] = 'close',

            -- You can still keep the classic “close on file open” behaviour
            -- by binding a key you rarely use (e.g. <Leader>q):
            ['<leader>q'] = function(state)
              local node = state.tree:get_node()
              if node and node.type == 'file' then
                require('neo-tree.sources.filesystem').open(state, node)
                vim.cmd 'Neotree close'
              end
            end,
          },
        },

        -- ─────────────────────────────────────────────────────────────────
        -- 4️⃣  Optional niceties (icons, git, diagnostics)
        -- ─────────────────────────────────────────────────────────────────
        rendering = {
          indent_markers = {
            enable = true,
          },
          icons = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '󰜌',
            default = '',
            symlink = '',
          },
        },

        diagnostics = {
          enable = true,
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },

        git_status = {
          symbols = {
            added = '✚',
            modified = '',
            deleted = '✖',
            renamed = '➜',
            untracked = '',
            ignored = '◌',
            unstaged = '✗',
            staged = '✓',
            conflict = '',
          },
        },
      } -- end of require("neo-tree").setup()

      --------------------------------------------------------------------
      -- 5️⃣  Helper command: open file *without* moving focus (for <Enter>)
      --------------------------------------------------------------------
      vim.api.nvim_create_user_command('NeoTreeOpenKeepFocus', function()
        local state = require('neo-tree.ui.renderer').get_state()
        local node = state.tree:get_node()
        if node then
          require('neo-tree.sources.filesystem').open(state, node)
        end
      end, {})
      -- If you ever want to call it manually: :NeoTreeOpenKeepFocus
    end,
  },

  -- … other plugins …
}
