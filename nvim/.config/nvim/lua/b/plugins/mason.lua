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
        "bashls",
        "cssls",
        "cssmodules_ls",
        "emmet_language_server",
        "html",
        "jsonls",
        "lua_ls",
        "tsserver",
        "vimls",
        "yamlls",
      },
    })
  end
}
