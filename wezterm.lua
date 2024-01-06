local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()
config.keys = {}

-- Set colorscheme to Catppuccin
config.color_scheme = "Catppuccin Mocha"

return config
