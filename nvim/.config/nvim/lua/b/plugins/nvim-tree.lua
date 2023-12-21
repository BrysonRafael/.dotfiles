return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = 30,
      }
    })

    local set_keymap = vim.keymap.set
    set_keymap("n", "<leader>et", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "[E]xplorer Toggle" })
    set_keymap("n", "<leader>ef", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "[E]xplorer Focus" })
  end,
}
