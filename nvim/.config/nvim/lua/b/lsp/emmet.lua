--
-- emmet language server
-- https://github.com/olrtg/emmet-language-server
--

require('lspconfig').emmet_language_server.setup {
  capabilities = require('b.lsp').capabilities(),
  on_attach = require('b.lsp').on_attach,
}
