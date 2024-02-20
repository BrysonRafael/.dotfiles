--
-- json language server
--

require('lspconfig').jsonls.setup {
  init_options = {
    provideFormatter = true,
  },
  capabilities = require('b.lsp').capabilities(),
  on_attach = require('b.lsp').on_attach,
}
