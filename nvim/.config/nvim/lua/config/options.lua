-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- this file grows indefinitely and I only care about the current session
os.remove(vim.env.HOME .. "/.local/state/nvim/lsp.log")
vim.lsp.set_log_level("WARN") -- other options: "TRACE", "DEBUG", "INFO", "WARN", "ERROR", "OFF"
