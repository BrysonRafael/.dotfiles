return {
  "numToStr/Navigator.nvim",
  config = function ()
    require("Navigator").setup()

    local set_keymap = vim.keymap.set
    set_keymap({"n", "t"}, "<C-h>", "<CMD>NavigatorLeft<CR>")
    set_keymap({"n", "t"}, "<C-l>", "<CMD>NavigatorRight<CR>")
    set_keymap({"n", "t"}, "<C-k>", "<CMD>NavigatorUp<CR>")
    set_keymap({"n", "t"}, "<C-j>", "<CMD>NavigatorDown<CR>")
    set_keymap({"n", "t"}, "<C-p>", "<CMD>NavigatorPrevious<CR>")
  end
}
