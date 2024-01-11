return {
  "vim-test/vim-test",
  config = function()
    vim.g["test#strategy"] = "wezterm"

    local set_keymap = vim.api.nvim_set_keymap
    set_keymap("n", "<leader>tf", "<cmd>TestFile<cr>", { noremap = true, silent = true, desc = "[T]est File" })
    set_keymap("n", "<leader>tn", "<cmd>TestNearest<cr>", { noremap = true, silent = true, desc= "[T]est Nearest" })
    set_keymap("n", "<leader>tl", "<cmd>TestLast<cr>", { noremap = true, silent = true, desc = "[T]est Last" })
    set_keymap("n", "<leader>ta", "<cmd>TestSuite<cr>", { noremap = true, silent = true, desc = "[T]est All" })
  end,
}
