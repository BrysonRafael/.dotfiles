vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.netrw_liststyle = 3

local set_keymap = vim.keymap.set

-- Resize buffer panes with option + arrow keys
set_keymap('n', '<S-Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })
set_keymap('n', '<S-Left>', ':vertical resize +2<CR>', { noremap = true, silent = true })
set_keymap('n', '<S-Up>', ':resize +2<CR>', { noremap = true, silent = true })
set_keymap('n', '<S-Down>', ':resize -2<CR>', { noremap = true, silent = true })

-- Make buffer panes same width
set_keymap('n', '<leader>=', ':wincmd =<CR>', { noremap = true, silent = true, desc = '[=] Equalize buffer pane widths' })

-- Move to the next buffer
set_keymap('n', '<S-l>', ':bnext<CR>', { noremap = true, silent = true })

-- Move to the previous buffer
set_keymap('n', '<S-h>', ':bprev<CR>', { noremap = true, silent = true })

-- Delete the current buffer
set_keymap('n', '<S-d>', ':bd<CR>', { noremap = true, silent = true })

-- Create tab
set_keymap('n', '<Tab>c', ':tabnew<CR>', { noremap = true, silent = true })

-- Next tab
set_keymap('n', '<Tab>n', ':tabnext<CR>', { noremap = true, silent = true })

-- Previous tab
set_keymap('n', '<Tab>p', ':tabprevious<CR>', { noremap = true, silent = true })

-- Close tab
set_keymap('n', '<Tab>d', ':tabclose<CR>', { noremap = true, silent = true })
