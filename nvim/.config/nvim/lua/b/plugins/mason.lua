return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function ()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bash-language-server",
        "css-lsp",
        "cssmodules-language-server",
        "emmet-language-server",
        "html-lsp",
        "typescript-language-server",
        "json-lsp",
        "lua-language-server",
        "tailwindcss-language-server",
        "vim-language-server",
        "yaml-language-server",
      }
    })
  end
}
