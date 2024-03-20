require('neodev').setup()

require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      -- https://github.com/LuaLS/lua-language-server/wiki/Settings
      completion = { enable = true, showWord = 'Disable' },
      diagnostics = { globals = { 'vim', 'hs' } },
      hint = { enable = true, arrayIndex = 'Disable' },
      format = { enable = false },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
  capabilities = require('b.lsp').capabilities(),
  on_attach = require('b.lsp').on_attach,
}
