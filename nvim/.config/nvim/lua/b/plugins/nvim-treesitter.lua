return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'windwp/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise',
  },
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter.configs'

    treesitter.setup {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = false },
      autotag = { enable = true },
      endwise = { enable = true },
      ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'git_config',
        'git_rebase',
        'gitcommit',
        'gitignore',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'ruby',
        'sql',
        'tsx',
        'typescript',
        'vim',
        'yaml',
      },
      keymaps = {
        ['im'] = '@block.inner',
        ['am'] = '@block.outer',
      },
    }
  end,
}
