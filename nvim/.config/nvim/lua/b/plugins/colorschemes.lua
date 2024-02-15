return {
  {
    "catppuccin/nvim",
    lazy = false,
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
    lazy = false,
    priority = 1000,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "sekke276/dark_flat.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "alexmozaidze/palenight.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "tanvirtin/monokai.nvim",
    lazy = false,
    priority = 1000,
  },
}
