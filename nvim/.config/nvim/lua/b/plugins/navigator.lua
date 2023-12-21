return {
  "numToStr/Navigator.nvim",
  config = function ()
    local navigator = require("Navigator")
    navigator.setup()

    local set_keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }
    set_keymap("n", "<C-h>", navigator.left, opts)
    set_keymap("n", "<C-l>", navigator.right, opts)
    set_keymap("n", "<C-k>", navigator.up, opts)
    set_keymap("n", "<C-j>", navigator.down, opts)
    set_keymap("n", "<C-p>", navigator.previous, opts)
  end
}
