--
-- vim language server
--

require("lspconfig").vimls.setup({
  init_options = { isNeovim = true },
  capabilities = require("b.lsp").capabilities(),
  on_attach = require("b.lsp").on_attach,
})
