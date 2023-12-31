local wezterm = require("wezterm")
local config = {}
local action = wezterm.action

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "BlulocoDark"
config.font_size = 14
config.line_height = 1.1
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = "0.5cell",
  right = "0.5cell",
  top = "0.5cell",
  bottom = 0,
}

-- Setup Navigator WezTerm Integration
-- https://github.com/numToStr/Navigator.nvim/wiki/WezTerm-Integration
local function isViProcess(pane)
  -- get_foreground_process_name On Linux, macOS and Windows, 
  -- the process can be queried to determine this path. Other operating systems 
  -- (notably, FreeBSD and other unix systems) are not currently supported
  return pane:get_foreground_process_name():find("n?vim") ~= nil
  -- return pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if isViProcess(pane) then
    window:perform_action(
      -- This should match the keybinds you set in Neovim.
      action.SendKey({ key = vim_direction, mods = "CTRL"}),
      pane
    )
  else
    window:perform_action(action.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  conditionalActivatePane(window, pane, "Down", "j")
end)

config.keys = {
  -- Pane Naviation
  { key = "h", mods = "CTRL", action = action.EmitEvent("ActivatePaneDirection-left") },
  { key = "j", mods = "CTRL", action = action.EmitEvent("ActivatePaneDirection-down") },
  { key = "k", mods = "CTRL", action = action.EmitEvent("ActivatePaneDirection-up") },
  { key = "l", mods = "CTRL", action = action.EmitEvent("ActivatePaneDirection-right") },

  -- Split Panes
  { key = "-", mods = "CTRL|ALT", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "\\", mods = "CTRL|ALT", action = action.SplitHorizontal({ domain = "CurrentPaneDomain"}) },

  -- Pane Resizing
  { key = "LeftArrow", mods = "CTRL|ALT", action = action.AdjustPaneSize({ "Left", 5 }) },
  { key = "DownArrow", mods = "CTRL|ALT", action = action.AdjustPaneSize({ "Down", 5 }) },
  { key = "UpArrow", mods = "CTRL|ALT", action = action.AdjustPaneSize({ "Up", 5 }) },
  { key = "RightArrow", mods = "CTRL|ALT", action = action.AdjustPaneSize({ "Right", 5 }) },
  { key = "z", mods = "CTRL|ALT", action = action.TogglePaneZoomState },

  -- Copy to clipboard
  { key = "C", mods = "CTRL", action = action.CopyTo("ClipboardAndPrimarySelection") },

  -- Tab Navigation
  { key = "[", mods = "CTRL|ALT", action = action.ActivateTabRelative(-1) },
  { key = "]", mods = "CTRL|ALT", action = action.ActivateTabRelative(1) },
}

return config
