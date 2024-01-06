local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()
config.keys = {}

-- Set colorscheme to Catppuccin
config.color_scheme = "Catppuccin Mocha"
-- Set font to JetBrains Mono
config.font = wezterm.font("JetBrains Mono")
-- Configure tab bar appearance
config.window_frame = {
	-- Set font to SF Compact Text
	font = wezterm.font("SF Compact Text"),
}

return config
