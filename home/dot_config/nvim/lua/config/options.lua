-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- this file grows indefinitely and I only care about the current session
os.remove(vim.env.HOME .. "/.local/state/nvim/lsp.log")
vim.lsp.log.set_level("WARN") -- other options: "TRACE", "DEBUG", "INFO", "WARN", "ERROR", "OFF"

-- Remote plugin providers are unused, and installing them globally would fight
-- with the per-project devbox/nix toolchains. Disable them so :checkhealth
-- stops asking for global gems/npm packages/pip modules.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
