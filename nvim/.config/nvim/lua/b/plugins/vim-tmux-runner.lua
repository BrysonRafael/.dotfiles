return {
  "christoomey/vim-tmux-runner",
  keys = {
    { "<leader>ra", "<cmd>VtrAttachToPane<cr>", desc = "[R]unner Attach To Pane" },
    { "<leader>rf", "<cmd>VtrFocusRunner<cr>", desc = "[R]unner Focus" },
    { "<leader>rl", "<cmd>VtrSendLinesToRunner<cr>", desc = "Send Lines To [R]unner" },
  }
}
