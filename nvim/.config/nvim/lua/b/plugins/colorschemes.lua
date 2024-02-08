return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").load()
      vim.cmd.colorscheme("nordic")
    end
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
  },
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
}
