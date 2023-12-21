return {
  "numToStr/Navigator.nvim",
  config = function ()
    local navigator = require("Navigator")
    navigator.setup()

    local set_keymap = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    set_keymap("n", "<C-h>", "<CMD>NavigatorLeft<CR>", opts)
    set_keymap("n", "<C-l>", "<CMD>NavigatorRight<CR>", opts)
    set_keymap("n", "<C-k>", "<CMD>NavigatorUp<CR>", opts)
    set_keymap("n", "<C-j>", "<CMD>NavigatorDown<CR>", opts)
    set_keymap("n", "<C-p>", "<CMD>NavigatorPrevious<CR>", opts)
  end
}
