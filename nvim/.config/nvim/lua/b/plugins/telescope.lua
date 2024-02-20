-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
          },
        },
      },
    }

    telescope.load_extension 'fzf'

    local builtin = require 'telescope.builtin'
    local set_keymap = vim.keymap.set
    set_keymap('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    set_keymap('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    set_keymap('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    local function telescope_live_grep_open_files()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end
    set_keymap('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[/] in Open Files' })
    set_keymap('n', '<leader>ss', builtin.builtin, { desc = '[s]elect Telescope' })
    set_keymap('n', '<leader>sf', builtin.find_files, { desc = '[f]iles' })
    set_keymap('n', '<leader>sh', builtin.help_tags, { desc = '[h]elp' })
    set_keymap('n', '<leader>sw', builtin.grep_string, { desc = 'Current [w]ord' })
    set_keymap('n', '<leader>sg', builtin.live_grep, { desc = '[g]rep' })
    set_keymap('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[G]rep on Git Root' })
    set_keymap('n', '<leader>sd', builtin.diagnostics, { desc = '[d]iagnostics' })
    set_keymap('n', '<leader>sr', builtin.resume, { desc = '[r]esume' })
  end,
}
