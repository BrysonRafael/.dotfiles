--
-- bash language server
--

require('lspconfig').bashls.setup {
  capabilities = require('b.lsp').capabilities(),
  on_attach = require('b.lsp').on_attach,
}
