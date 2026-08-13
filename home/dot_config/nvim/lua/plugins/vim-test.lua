return {
  "vim-test/vim-test",
  dependencies = { "preservim/vimux" },
  config = function()
    vim.g["test#strategy"] = "vimux"
  end,
  keys = {
    { "<leader>tf", ":TestFile <cr>", desc = "[f]ile" },
    { "<leader>tn", ":TestNearest <cr>", desc = "[n]earest" },
    { "<leader>tl", ":TestLast <cr>", desc = "[l]ast" },
    { "<leader>ta", ":TestSuite <cr>", desc = "[a]ll" },
  },
}
