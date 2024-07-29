return {
  'folke/which-key.nvim',
  opts = {},
  config = function()
    require('which-key').add {
      { '<leader>-', group = '[-] Oil File Explorer' },
      { '<leader>-_', hidden = true },
      { '<leader>c', group = '[c]opiot chat' },
      { '<leader>c_', hidden = true },
      { '<leader>f', group = '[f]ind' },
      { '<leader>f_', hidden = true },
      { '<leader>l', group = '[l]sp' },
      { '<leader>l_', hidden = true },
      { '<leader>r', group = '[r]unner' },
      { '<leader>r_', hidden = true },
      { '<leader>t', group = '[t]est' },
      { '<leader>t_', hidden = true },
    }
    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    require('which-key').add {
      { '', group = 'VISUAL <leader>', mode = 'v' },
    }
  end,
}
