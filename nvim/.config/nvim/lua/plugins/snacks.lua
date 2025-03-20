---@diagnostic disable: undefined-doc-name

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
        },
        files = { hidden = true },
      },
    },
    scratch = {
      ft = "markdown",
    },
  },
}
