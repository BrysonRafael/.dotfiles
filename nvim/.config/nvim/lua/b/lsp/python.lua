--
-- python language server
--

require("lspconfig").pylsp.set({
  capabilities = require("b.lsp").capabilities(),
  on_attach = require("b.lsp").on_attach,
})
