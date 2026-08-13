return {
  "numToStr/Navigator.nvim",
  config = function()
    -- Use the herdr custom mux backend (lua/config/herdr_mux.lua) instead of
    -- auto-detection, which only recognizes tmux/wezterm/kitty.
    require("Navigator").setup({ mux = require("config.herdr_mux") })
  end,
}
