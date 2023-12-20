--
-- css language server
--

require("lspconfig").cssls.setup({
  capabilities = require("b.lsp").capabilities(),
  on_attach = require("b.lsp").on_attach,
})
