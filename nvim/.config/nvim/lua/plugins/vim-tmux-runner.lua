return {
  "christoomey/vim-tmux-runner",
  keys = {
    { "<leader>ra", ":VtrAttachToPane<cr>", desc = "Attach runner to pane" },
    { "<leader>rf", ":VtrRunnerFocus<cr>", desc = "Focus runner" },
    { "<leader>rs", ":VtrSendLinesToRunner<cr>", desc = "Send lines to runner" },
    { "<leader>rk", ":VtrSendCtrlD<cr>", desc = "Kill runner" },
  },
}
