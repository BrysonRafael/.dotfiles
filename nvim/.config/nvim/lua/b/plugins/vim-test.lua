return {
  "vim-test/vim-test",
  keys = {
    { "<leader>tf", "<cmd>TestFile -strategy=vtr<cr>", desc = "[T]est File" },
    { "<leader>tn", "<cmd>TestNearest -strategy=vtr<cr>", desc = "[T]est Nearest" },
    { "<leader>tl", "<cmd>TestLast -strategy=vtr<cr>", desc = "[T]est Last" },
    { "<leader>ta", "<cmd>TestSuite -strategy=vtr<cr>", desc = "[T]est All" },
  },
}
