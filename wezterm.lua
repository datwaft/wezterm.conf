local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()
config.keys = {}
config.key_tables = {}

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
-- Use CTRL+w for pane mappings with smart-splits.nvim
do
	-- Check if inside neovim using a variable set by smart-splits.nvim
	---@return boolean
	local function is_inside_vim(pane)
		return pane:get_user_vars().IS_NVIM == "true"
	end
	-- Use CTRL+w to activate pane manipulation mode
	config.leader = { key = "w", mods = "CTRL" }
	-- Send CTRL+w when pressing it twice
	config.keys = {
		{ key = "w", mods = "LEADER|CTRL", action = act.SendKey({ key = "w", mods = "CTRL" }) },
		table.unpack(config.keys),
	}
	-- Set mappings for pane manipulation
	config.keys = {
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action_callback(function(window, pane)
				if is_inside_vim(pane) then
					window:perform_action({ SendKey = { key = "v", mods = "LEADER" } }, pane)
				else
					window:perform_action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }, pane)
				end
			end),
		},
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action_callback(function(window, pane)
				if is_inside_vim(pane) then
					window:perform_action({ SendKey = { key = "s", mods = "LEADER" } }, pane)
				else
					window:perform_action({ SplitVertical = { domain = "CurrentPaneDomain" } }, pane)
				end
			end),
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action_callback(function(window, pane)
				if is_inside_vim(pane) then
					window:perform_action({ SendKey = { key = "h", mods = "LEADER" } }, pane)
				else
					window:perform_action({ ActivatePaneDirection = "Left" }, pane)
				end
			end),
		},
		{
			key = "j",
			mods = "LEADER",
			action = wezterm.action_callback(function(window, pane)
				if is_inside_vim(pane) then
					window:perform_action({ SendKey = { key = "j", mods = "LEADER" } }, pane)
				else
					window:perform_action({ ActivatePaneDirection = "Down" }, pane)
				end
			end),
		},
		{
			key = "k",
			mods = "LEADER",
			action = wezterm.action_callback(function(window, pane)
				if is_inside_vim(pane) then
					window:perform_action({ SendKey = { key = "k", mods = "LEADER" } }, pane)
				else
					window:perform_action({ ActivatePaneDirection = "Up" }, pane)
				end
			end),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action_callback(function(window, pane)
				if is_inside_vim(pane) then
					window:perform_action({ SendKey = { key = "l", mods = "LEADER" } }, pane)
				else
					window:perform_action({ ActivatePaneDirection = "Right" }, pane)
				end
			end),
		},
		table.unpack(config.keys),
	}
end

return config
