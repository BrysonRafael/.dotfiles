return {
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
  },
  {
    'tanvirtin/monokai.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'carbonfox'
    end,
  },
}
