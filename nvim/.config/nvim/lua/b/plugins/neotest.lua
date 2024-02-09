return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
    "olimorris/neotest-rspec",
    "zidhuss/neotest-minitest",
  },
  config = function ()
    require("neotest").setup({
      adapters = {
        require("neotest-jest"),
        require("neotest-rspec"),
        require("neotest-minitest"),
      }
    })

    local set_keymap = vim.api.nvim_set_keymap
    set_keymap("n", "<leader>tf", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>", { noremap = true, silent = true, desc = "[f]ile" })
    set_keymap("n", "<leader>tn", ":lua require('neotest').run.run()<CR>", { noremap = true, silent = true, desc= "[n]earest" })
    set_keymap("n", "<leader>to", ":Neotest output<CR>", { noremap = true, silent = true, desc= "[o]utput" })
    set_keymap("n", "<leader>tp", ":Neotest output-panel<CR>", { noremap = true, silent = true, desc= "Output [p]anel" })
    set_keymap("n", "<leader>ts", ":Neotest summary<CR>", { noremap = true, silent = true, desc= "Toggle [s]ummary" })
  end
}
