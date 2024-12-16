-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable relative line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = false
  end,
})

-- Enable relative line numbers in not in insert mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

-- Disable LSP, completion, and Copilot in scratch buffers
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "nofile" then
      -- Stop LSP clients attached to the current buffer
      local clients = vim.lsp.get_clients()
      for _, client in ipairs(clients) do
        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
          vim.lsp.stop_client(client.id)
        end
      end

      -- Disable GitHub Copilot
      vim.b.copilot_enabled = false
    end
  end,
})
