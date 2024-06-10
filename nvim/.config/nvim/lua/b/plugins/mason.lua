return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    require('mason').setup()

    -- automatic lsp server installs
    require('mason-lspconfig').setup {
      automatic_installation = {
        exclude = { 'rubocop', 'ruby_lsp', 'solargraph', 'syntax_tree' },
      },
    }

    -- mason auto-update
    require('mason-tool-installer').setup {
      ensure_installed = {
        'codelldb',
        'codespell',
        'commitlint',
        'glow',
        'luacheck',
        'prettierd',
        'ripper-tags', -- used by vim-gutentags
        'selene',
        'shellcheck', -- used by bash-language-server
        'stylua',
        'tailwindcss-language-server',
        'tsserver', -- used by typescript-tools.nvim
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 10000,
      debounce_hours = 5,
    }
  end,
}
