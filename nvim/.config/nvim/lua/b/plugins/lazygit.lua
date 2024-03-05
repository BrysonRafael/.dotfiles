return {
  'kdheepak/lazygit.nvim',
  config = function()
    require('lazy').setup {
      {
        'kdheepak/lazygit.nvim',
        cmd = {
          'LazyGit',
          'LazyGitConfig',
          'LazyGitCurrentFile',
          'LazyGitFilter',
          'LazyGitFilterCurrentFile',
        },
        dependencies = {
          'nvim-lua/plenary.nvim',
        },
      },
    }
  end,
}
