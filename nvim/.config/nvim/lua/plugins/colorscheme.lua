return {
  {
    "gmr458/vscode_modern_theme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode_modern").setup({
        cursorline = true,
        transparent_background = false,
        nvim_tree_darker = true,
      })
      vim.o.background = "light"

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "vscode_modern",
        callback = function()
          local hl = vim.api.nvim_set_hl
          hl(0, "NormalFloat", { bg = "#ffffff" })
          hl(0, "FloatBorder", { bg = "#ffffff", fg = "#000000" })
          hl(0, "SnacksPickerList", { bg = "#ffffff" })
          hl(0, "SnacksPickerListBorder", { bg = "#ffffff", fg = "#000000" })
          hl(0, "SnacksPickerPreview", { bg = "#ffffff" })
          hl(0, "SnacksPickerPreviewBorder", { bg = "#ffffff", fg = "#000000" })
          hl(0, "SnacksPickerInput", { bg = "#ffffff" })
          hl(0, "SnacksPickerInputBorder", { bg = "#ffffff", fg = "#000000" })
          hl(0, "SnacksPickerPrompt", { fg = "#000000", bg = "#ffffff" })
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode_modern",
    },
  },
}
