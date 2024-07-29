local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 18
config.hide_tab_bar_if_only_one_tab = true

return config
