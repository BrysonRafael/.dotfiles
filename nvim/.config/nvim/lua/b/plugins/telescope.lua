return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-frecency.nvim',
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    local lga_actions = require 'telescope-live-grep-args.actions'

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-j>'] = actions.move_selection_next,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
            },
          },
        },
      },
    }

    telescope.load_extension 'fzf'
    telescope.load_extension 'frecency'

    local builtin = require 'telescope.builtin'
    local set_keymap = vim.keymap.set
    set_keymap('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    set_keymap('n', '<leader><space>', function()
      require('telescope').extensions.frecency.frecency { workspace = 'CWD' }
    end, { desc = '[ ] Find recently used files' })
    set_keymap('n', '<leader>/', function()
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
    set_keymap('n', '<leader>f/', telescope_live_grep_open_files, { desc = '[/] in Open Files' })
    set_keymap('n', '<leader>fs', builtin.builtin, { desc = '[s]elect Telescope' })
    set_keymap('n', '<leader>ff', builtin.find_files, { desc = '[f]iles' })
    set_keymap('n', '<leader>fh', builtin.help_tags, { desc = '[h]elp' })
    set_keymap('n', '<leader>fw', builtin.grep_string, { desc = 'Current [w]ord' })
    set_keymap('n', '<leader>fg', function()
      telescope.extensions.live_grep_args.live_grep_args()
    end, { desc = '[g]rep' })
    set_keymap('n', '<leader>fG', ':LiveGrepGitRoot<cr>', { desc = '[G]rep on Git Root' })
    set_keymap('n', '<leader>fd', builtin.diagnostics, { desc = '[d]iagnostics' })
    set_keymap('n', '<leader>fr', builtin.resume, { desc = '[r]esume' })
    set_keymap('n', '<leader>fR', builtin.registers, { desc = '[R]egisters' })
    set_keymap('n', '<leader>fb', builtin.buffers, { desc = '[b]uffers' })
  end,
}
