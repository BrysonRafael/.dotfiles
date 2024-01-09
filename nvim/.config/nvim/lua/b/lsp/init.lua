local M = {}

function M.setup()
  -- change border for lsp floats to single
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "single"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  -- configure servers
  require("b.lsp.bash")
  require("b.lsp.css")
  require("b.lsp.emmet")
  require("b.lsp.html")
  require("b.lsp.javascript")
  require("b.lsp.json")
  require("b.lsp.lua")
  require("b.lsp.ruby")
  require("b.lsp.vim")
  require("b.lsp.yaml")
end

function M.capabilities()
  return require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

function M.on_attach(client)
  local function opts(desc)
    return {
      buffer = 0,
      desc = "LSP: " .. desc,
    }
  end

  vim.api.nvim_create_user_command("LspFormat", function()
    vim.lsp.buf.format()
  end, { desc = "LSP: format with language servers" })

  local set_keymap = vim.keymap.set
  set_keymap("n", "gld", "<cmd>Telescope lsp_definitions<cr>", opts("goto definitions"))
  set_keymap("n", "glt", "<cmd>Telescope lsp_type_definitions<cr>", opts("goto type definitions"))
  set_keymap("n", "glD", vim.lsp.buf.declaration, opts("goto declaration"))
  set_keymap("n", "gli", "<cmd>Telescope lsp_implementations<cr>", opts("goto implementations"))
  set_keymap("n", "glr", "<cmd>Telescope lsp_references<cr>", opts("goto references"))
  set_keymap("n", "glS", vim.lsp.buf.signature_help, opts("signature help"))
  set_keymap("n", "gls", "<cmd>Telescope lsp_document_symbols<cr>", opts("document symbols"))
  set_keymap("n", "glw", "<cmd>Telescope lsp_workspace_symbols<cr>", opts("workspace symbols"))
  set_keymap("n", "<F2>", vim.lsp.buf.rename, opts("rename"))

  set_keymap("n", "glh", function()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
  end)

  set_keymap("n", "K", vim.lsp.buf.hover, opts("hover"))
  set_keymap({ "n", "v" }, "gla", vim.lsp.buf.code_action, opts("code actions"))

  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end

  if client.server_capabilities.inlayHintProvider then
    if client.name ~= "tsserver" then -- need newer typescript in my projects
      vim.lsp.inlay_hint.enable()
    end
  end
end

return M
