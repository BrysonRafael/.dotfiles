return {
  {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
  },
  {
    'embark-theme/vim',
    lazy = false,
    priority = 1000,
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
