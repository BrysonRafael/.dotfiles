--
-- tailwind language server
--

require("lspconfig").tailwindcss.setup({
  capabilities = require("b.lsp").capabilities(),
  on_attach = require("b.lsp").on_attach,
})
