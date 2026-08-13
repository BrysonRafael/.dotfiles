return {
  "vim-test/vim-test",
  config = function()
    -- Was "vimux", which shells out to tmux and so broke on the move to Herdr
    -- (https://herdr.dev/docs/). No vim-test strategy targets Herdr panes, so
    -- run tests in a Neovim :terminal split instead. "sticky" reuses one
    -- terminal across runs rather than stacking a new split each time.
    vim.g["test#strategy"] = "neovim_sticky"

    -- Bottom split, 15 rows — matches the vimux pane this replaces.
    vim.g["test#neovim#term_position"] = "botright 15"

    -- Without this, closing the split sends later runs to a hidden buffer.
    vim.g["test#neovim_sticky#reopen_window"] = 1

    -- Ctrl-C a still-running test before starting the next one.
    vim.g["test#neovim_sticky#kill_previous"] = 1
  end,
  keys = {
    { "<leader>tf", ":TestFile <cr>", desc = "[f]ile" },
    { "<leader>tn", ":TestNearest <cr>", desc = "[n]earest" },
    { "<leader>tl", ":TestLast <cr>", desc = "[l]ast" },
    { "<leader>ta", ":TestSuite <cr>", desc = "[a]ll" },
  },
}
