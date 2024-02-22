return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'bashls',
        'cssls',
        'eslint',
        'html',
        'jsonls',
        'lua_ls',
        'pylsp',
        'tsserver',
        'vimls',
        'yamlls',
      },
    }
  end,
}
