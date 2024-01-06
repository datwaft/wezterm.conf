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
-- Close current pane instead of window with CMD+w and CTRL+SHIFT+w and do not ask for confirmation
config.keys = {
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },
	table.unpack(config.keys),
}
-- Set LEADER key
config.leader = { key = "a", mods = "CMD", timeout_milliseconds = 1000 }
-- Send LEADER key when pressing it twice
config.keys = {
	{ key = "a", mods = "LEADER|CMD", action = act.SendKey({ key = "a", mods = "CMD" }) },
	table.unpack(config.keys),
}
-- Mappings for splitting screen
config.keys = {
	{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "=", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	table.unpack(config.keys),
}

return config
