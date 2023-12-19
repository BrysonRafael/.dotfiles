local api = vim.api
local b = vim.api.nvim_create_augroup("MyAutoCmds", { clear = true })

-- highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = b,
  pattern = "*",
})

-- show cursor line only in active window
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  command = "set cursorline",
  group = b,
})

api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  command = "set nocursorline",
  group = b,
})

-- new lines with "o" or "O" from commented lines don"t continue commenting
api.nvim_create_autocmd("FileType", {
  command = "setlocal formatoptions-=o",
  group = b,
})
