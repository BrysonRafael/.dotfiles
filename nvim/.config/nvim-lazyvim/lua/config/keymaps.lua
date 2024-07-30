-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Navigator
local navigator = require("Navigator")
local map = vim.keymap.set
map("n", "<C-h>", navigator.left, { noremap = true, silent = true })
map("n", "<C-l>", navigator.right, { noremap = true, silent = true })
map("n", "<C-k>", navigator.up, { noremap = true, silent = true })
map("n", "<C-j>", navigator.down, { noremap = true, silent = true })

-- Which Key
local wk = require("which-key")

wk.add({
  { "<leader>r", desc = "runner" },
  { "<leader>t", desc = "test" },
})
