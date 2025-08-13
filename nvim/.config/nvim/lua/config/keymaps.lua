-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Copy to clipboard
map("v", "<leader>y", '"+y', { noremap = true, silent = true })

-- Save with Ctrl+s
map({ "n" }, "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true, desc = "Save file" })

-- Quit with Ctrl+q
map({ "n" }, "<C-q>", "<cmd>q<CR>", { noremap = true, silent = true, desc = "Quit" })

-- Close buffer with Ctrl+x
map({ "n" }, "<C-x>", "<cmd>bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })

-- Navigator
local navigator = require("Navigator")
map("n", "<C-h>", navigator.left, { noremap = true, silent = true })
map("n", "<C-l>", navigator.right, { noremap = true, silent = true })
map("n", "<C-k>", navigator.up, { noremap = true, silent = true })
map("n", "<C-j>", navigator.down, { noremap = true, silent = true })

-- Which Key
local wk = require("which-key")
wk.add({
  { "<leader>t", desc = "test" },
  { "<leader>y", desc = "yank to clipboard", mode = "v" },
})
