-- Custom Navigator.nvim multiplexer backend for Herdr (https://herdr.dev/docs/).
-- Herdr has no built-in editor-navigation integration, so <C-h/j/k/l> at the
-- edge of the last vim split is forwarded to Herdr over its CLI:
--   * TUI (HERDR_PANE_ID set):   `herdr pane focus --direction <dir>`
--   * GUI app (HC_TERMINAL_ID):  `herdr-app do pane.go:<dir>`
-- The other half of this integration forwards keys back into vim/lazygit
-- panes: the herdr-nav script (~/.config/herdr/bin, bound in config.toml) for
-- the TUI, and the vimnav mod (~/.config/herdr-app/mods/vimnav, bound in
-- keys.json) for the GUI app.
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
  local herdr_direction = DIRECTION[direction]
  if herdr_direction == nil then
    return self
  end

  -- TUI first: a TUI session attached inside a GUI pane has both variables,
  -- and the innermost multiplexer should move.
  if vim.env.HERDR_PANE_ID ~= nil then
    vim.system({ "herdr", "pane", "focus", "--direction", herdr_direction })
  elseif vim.env.HC_TERMINAL_ID ~= nil then
    vim.system({ "herdr-app", "do", "pane.go:" .. herdr_direction })
  end
  -- Otherwise not inside a herdr pane (e.g. tmux, or a plain terminal) — no-op.
  return self
end

return Mux
