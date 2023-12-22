local wezterm = require("wezterm")
local config = {}

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

config.keys = {
  -- Option + \ for Vertical Split
  {
    key = "-",
    mods = "ALT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
    -- Option + - for Horizontal Split
  {
    key = "\\",
    mods = "ALT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
}

return config