-- Custom Navigator.nvim multiplexer backend for Herdr (https://herdr.dev/docs/).
-- Herdr has no built-in editor-navigation integration, so <C-h/j/k/l> at the
-- edge of the last vim split is forwarded to `herdr pane focus` over its CLI
-- (which talks to the local socket API). The other half of this integration
-- is the herdr-nav script in herdr/.config/herdr/bin, bound to ctrl+h/j/k/l
-- in config.toml, which forwards keys back into vim/lazygit panes.
--
-- See: https://github.com/numToStr/Navigator.nvim/wiki/Custom-Multiplexer

---@class Mux
local Mux = {}

-- Navigator.nvim direction -> herdr `pane focus --direction` value
local DIRECTION = { h = "left", j = "down", k = "up", l = "right" }

---@return boolean
function Mux.zoomed()
  -- Herdr panes don't have a vim-visible zoom state worth blocking on here;
  -- mirrors Navigator's own Neovim-only backend, which always returns false.
  return false
end

---@param direction Direction
---@return Mux
function Mux:navigate(direction)
  -- Not running inside a herdr pane (e.g. tmux, or a plain terminal) — no-op.
  if vim.env.HERDR_PANE_ID == nil then
    return self
  end

  local herdr_direction = DIRECTION[direction]
  if herdr_direction == nil then
    return self
  end

  vim.system({ "herdr", "pane", "focus", "--direction", herdr_direction })
  return self
end

return Mux
