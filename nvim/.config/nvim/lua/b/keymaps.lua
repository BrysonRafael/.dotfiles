vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_liststyle = 3

local set_keymap = vim.api.nvim_set_keymap

-- Resize windows with option + arrow keys
set_keymap("n", "<M-Right>", ":vertical resize -2<CR>", { noremap = true, silent = true })
set_keymap("n", "<M-Left>", ":vertical resize +2<CR>", { noremap = true, silent = true })
set_keymap("n", "<M-Up>", ":resize -2<CR>", { noremap = true, silent = true })
set_keymap("n", "<M-Down>", ":resize +2<CR>", { noremap = true, silent = true })

-- Move to the next buffer
set_keymap("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true, desc = "[B]uffer Next" })
set_keymap("n", "<M-]>", ":bnext<CR>", { noremap = true, silent = true, desc = "[B]uffer Next" })

-- Move to the previous buffer
set_keymap("n", "<leader>bp", ":bprev<CR>", { noremap = true, silent = true, desc = "[B]uffer Previous" })
set_keymap("n", "<M-[>", ":bprev<CR>", { noremap = true, silent = true, desc = "[B]uffer Previous" })

-- Delete the current buffer
set_keymap("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true, desc = "[B]uffer Delete" })
set_keymap("n", "<M-d>", ":bd<CR>", { noremap = true, silent = true, desc = "[B]uffer Delete" })

-- Delete all buffers
set_keymap("n", "<leader>bda", ":%bd<CR>", { noremap = true, silent = true, desc = "[B]uffer Delete All" })
