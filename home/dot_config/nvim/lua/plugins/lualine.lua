return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = "",
      section_separators = "",
    },
    sections = {
      lualine_b = { "branch" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "filetype" },
      lualine_y = {},
      lualine_z = { "location" },
    },
  },
}
