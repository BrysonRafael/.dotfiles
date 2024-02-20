return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- See `:help lualine.txt`
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
    },
  },
}
