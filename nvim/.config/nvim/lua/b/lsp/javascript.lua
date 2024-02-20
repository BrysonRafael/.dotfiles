--
-- javascript language servers
--

local capabilities = require('b.lsp').capabilities()
local on_attach = require('b.lsp').on_attach

-- javascript / typescript
-- this plugin calls lspconfig and sets up tsserver
require('typescript-tools').setup {
  debug = false,
  capabilities = capabilities,
  on_attach = on_attach,
}

-- eslint
require('lspconfig').eslint.setup {
  settings = {
    validate = 'on',
    codeAction = {
      disableRuleComment = {
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
}
