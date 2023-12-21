vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_liststyle = 3

local keymap = vim.api.nvim_set_keymap


-- Buffer Navigation --

-- Move to the next buffer
keymap("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true, desc = "[B]uffer Next" })
keymap("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true, desc = "[B]uffer Next" })

-- Move to the previous buffer
keymap("n", "<leader>bp", ":bprev<CR>", { noremap = true, silent = true, desc = "[B]uffer Previous" })
keymap("n", "<S-h>", ":bprev<CR>", { noremap = true, silent = true, desc = "[B]uffer Previous" })

-- Delete the current buffer
keymap("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true, desc = "[B]uffer Delete" })
keymap("n", "<S-d>", ":bd<CR>", { noremap = true, silent = true, desc = "[B]uffer Delete" })

-- Delete all buffers
keymap("n", "<leader>bda", ":%bd<CR>", { noremap = true, silent = true, desc = "[B]uffer Delete All" })
