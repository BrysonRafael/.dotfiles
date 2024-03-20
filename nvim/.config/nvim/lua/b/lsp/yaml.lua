require('lspconfig').yamlls.setup {
  capabilities = require('b.lsp').capabilities(),
  on_attach = require('b.lsp').on_attach,
}
