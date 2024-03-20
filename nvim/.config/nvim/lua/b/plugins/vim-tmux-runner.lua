return {
  'christoomey/vim-tmux-runner',
  config = function()
    local set_keymap = vim.keymap.set
    set_keymap('n', '<leader>ra', ':VtrAttachToPane<cr>', { desc = '[a]ttach runner to pane' })
    set_keymap('n', '<leader>rf', ':VtrRunnerFocus<cr>', { desc = '[f]ocus runner' })
    set_keymap('n', '<leader>rs', ':VtrSendLinesToRunner<cr>', { desc = '[s]end lines to runner' })
    set_keymap('n', '<leader>rk', ':VtrSendCtrlD<cr>', { desc = '[k]ill runner' })
  end,
}
