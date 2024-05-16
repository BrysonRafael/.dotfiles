return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    'AndreM222/copilot-lualine',
  },
  opts = {
    options = {
      icons_enabled = false,
      component_separators = '|',
      section_separators = '',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1,
        },
      },
      lualine_x = {
        'copilot',
        'encoding',
        'fileformat',
        'filetype',
      },
    },
  },
}
