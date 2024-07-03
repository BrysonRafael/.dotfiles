return {
  'folke/which-key.nvim',
  opts = {},
  config = function()
    require('which-key').register {
      ['<leader>c'] = { name = '[c]opiot chat', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = '[l]sp', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[r]unner', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = '[f]ind', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[t]est', _ = 'which_key_ignore' },
      ['<leader>-'] = { name = '[-] Oil File Explorer', _ = 'which_key_ignore' },
    }
    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    require('which-key').register({
      ['<leader>'] = { name = 'VISUAL <leader>' },
    }, { mode = 'v' })
  end,
}
