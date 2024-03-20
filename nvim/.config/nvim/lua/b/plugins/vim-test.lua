return {
  'vim-test/vim-test',
  config = function()
    vim.g['test#strategy'] = 'vtr'

    local set_keymap = vim.keymap.set
    set_keymap('n', '<leader>tf', ':TestFile <cr>', { desc = '[f]ile' })
    set_keymap('n', '<leader>tn', ':TestNearest <cr>', { desc = '[n]earest' })
    set_keymap('n', '<leader>tl', ':TestLast <cr>', { desc = '[l]ast' })
    set_keymap('n', '<leader>ta', ':TestSuite <cr>', { desc = '[a]ll' })
  end,
}
