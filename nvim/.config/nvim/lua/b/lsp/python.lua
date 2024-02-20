--
-- python language server
--

local lsp = require 'b.lsp'

require('lspconfig').pylsp.setup {
  capabilities = lsp.capabilities(),
  on_attach = lsp.on_attach,
}
