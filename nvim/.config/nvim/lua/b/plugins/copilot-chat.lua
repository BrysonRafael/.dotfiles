return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      local chat = require 'CopilotChat'
      chat.setup { debug = true }

      local function quick_chat()
        local input = vim.fn.input 'Quick Chat: '
        if input ~= '' then
          chat.ask(input, { selection = chat.select.buffer })
        end
      end

      local set_keymap = vim.keymap.set
      set_keymap('n', '<leader>ct', ':CopilotChatToggle<CR>', { noremap = true, silent = true, desc = '[t]oggle' })
      set_keymap('n', '<leader>cq', function()
        quick_chat()
      end, { noremap = true, silent = true, desc = '[q]uick chat' })
      set_keymap('n', '<leader>cR', ':CopilotChatReset<CR>', { noremap = true, silent = true, desc = '[R]eset' })
      set_keymap('n', '<leader>cS', ':CopilotChatSave<CR>', { noremap = true, silent = true, desc = '[S]ave' })
      set_keymap('n', '<leader>cL', ':CopilotChatLoad<CR>', { noremap = true, silent = true, desc = '[L]oad' })
      set_keymap('n', '<leader>cF', ':CopilotChatFixDiagnostic<CR>', { noremap = true, silent = true, desc = '[F]ix diagnostic issue in file' })
      set_keymap('x', '<leader>ce', ':CopilotChatExplain<CR>', { noremap = true, silent = true, desc = '[e]xplain selected code' })
      set_keymap('x', '<leader>cr', ':CopilotChatReview<CR>', { noremap = true, silent = true, desc = '[r]eview selected code' })
      set_keymap('x', '<leader>cf', ':CopilotChatFix<CR>', { noremap = true, silent = true, desc = '[f]ix selected code' })
      set_keymap('x', '<leader>co', ':CopilotChatOptimize<CR>', { noremap = true, silent = true, desc = '[o]ptimize selected code' })
      set_keymap('x', '<leader>cd', ':CopilotChatDocs<CR>', { noremap = true, silent = true, desc = '[d]ocument selected code' })
      set_keymap('x', '<leader>cT', ':CopilotChatTests<CR>', { noremap = true, silent = true, desc = 'write [T]ests for selected code' })
    end,
  },
}
