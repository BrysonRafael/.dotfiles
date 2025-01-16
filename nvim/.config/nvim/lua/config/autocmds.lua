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
