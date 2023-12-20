vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_liststyle = 3

local keymap = vim.api.nvim_set_keymap

-- Window Navigation --

-- Navigate between windows using Ctrl + (h, j, k, l)
keymap("n", "<C-h>", "<C-w>h", { noremap = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- Resize windows with Shift + arrow keys
keymap("n", "<M-Right>", ":vertical resize -2<CR>", { noremap = true, silent = true })
keymap("n", "<M-Left>", ":vertical resize +2<CR>", { noremap = true, silent = true })
keymap("n", "<M-Up>", ":resize -2<CR>", { noremap = true, silent = true })
keymap("n", "<M-Down>", ":resize +2<CR>", { noremap = true, silent = true })


-- Buffer Navigation --

-- Move to the next buffer
keymap("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true, desc = "[B]uffer Next" })

-- Move to the previous buffer
keymap("n", "<leader>bp", ":bprev<CR>", { noremap = true, silent = true, desc = "[B]uffer Previous" })

-- Delete the current buffer
keymap("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true, desc = "[B]uffer Delete" })

-- Delete all buffers
keymap("n", "<leader>bda", ":%bd<CR>", { noremap = true, silent = true, desc = "[B]uffer Delete All" })


-- Tab Navigation --

-- Move to the next tab
keymap("n", "<leader>tn", ":tabnext<CR>", { noremap = true, silent = true, desc = "[T]ab Next" })

-- Move to the previous tab
keymap("n", "<leader>tp", ":tabprev<CR>", { noremap = true, silent = true, desc = "[T]ab Previous" })

-- Close the current tab
keymap("n", "<leader>td", ":tabclose<CR>", { noremap = true, silent = true, desc = "[T]ab Delete" })

-- Create a new tab
keymap("n", "<leader>tc", ":tabnew<CR>", { noremap = true, silent = true, desc = "[T]ab Create" })


