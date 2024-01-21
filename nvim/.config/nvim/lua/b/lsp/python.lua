--
-- python language server
--

local lspconfig = require("lspconfig")

lspconfig.pylsp.setup({
  capabilities = require("b.lsp").capabilities(),
  on_attach = require("b.lsp").on_attach,
})

lspconfig.pyright.setup({
  capabilities = require("b.lsp").capabilities(),
  on_attach = require("b.lsp").on_attach,
})
