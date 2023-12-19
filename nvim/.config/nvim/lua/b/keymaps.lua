vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- netrw
keymap.set("n", "<leader>e", vim.cmd.Lexplore)
vim.g.netrw_winsize = 30
vim.g.netrw_liststyle = 3

