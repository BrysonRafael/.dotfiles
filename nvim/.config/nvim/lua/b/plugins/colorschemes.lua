return {
  {
    'loctvl842/monokai-pro.nvim',
    name = 'monokai-pro',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'monokai-pro-default'
    end,
  },
}
