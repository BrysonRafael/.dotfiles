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
  require("b.lsp.python")
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
  set_keymap("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", { desc = "Go to [d]efinition" })
  set_keymap("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Go to [t]ype definition" })
  set_keymap("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Go to [D]eclaration" })
  set_keymap("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>", { desc = "Go to [i]mplementation" })
  set_keymap("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", { desc = "Go to [r]eferences" })
  set_keymap("n", "<leader>lR", vim.lsp.buf.rename, { desc = "[R]ename" })
  set_keymap("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "[s]ignature help" })
  set_keymap("n", "<leader>lS", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document [S]ymbols" })
  set_keymap("n", "<leader>lh", function()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
  end, { desc = "Inlay [h]int" })
  set_keymap("n", "H", vim.lsp.buf.hover, opts("hover"))
  set_keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { desc = "Code [a]ctions" })

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
