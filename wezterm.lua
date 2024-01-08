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
-- Never ask for confirmation when closing a window
config.window_close_confirmation = "NeverPrompt"
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
          window:perform_action(
            act.Multiple({
              act.SendKey({ key = "w", mods = "CTRL" }),
              act.SendKey({ key = "v" }),
            }),
            pane
          )
        else
          window:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
        end
      end),
    },
    {
      key = "s",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        if is_inside_vim(pane) then
          window:perform_action(
            act.Multiple({
              act.SendKey({ key = "w", mods = "CTRL" }),
              act.SendKey({ key = "s" }),
            }),
            pane
          )
        else
          window:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
        end
      end),
    },
    {
      key = "h",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        if is_inside_vim(pane) then
          window:perform_action(
            act.Multiple({
              act.SendKey({ key = "w", mods = "CTRL" }),
              act.SendKey({ key = "h" }),
            }),
            pane
          )
        else
          window:perform_action(act.ActivatePaneDirection("Left"), pane)
        end
      end),
    },
    {
      key = "j",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        if is_inside_vim(pane) then
          window:perform_action(
            act.Multiple({
              act.SendKey({ key = "w", mods = "CTRL" }),
              act.SendKey({ key = "j" }),
            }),
            pane
          )
        else
          window:perform_action(act.ActivatePaneDirection("Down"), pane)
        end
      end),
    },
    {
      key = "k",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        if is_inside_vim(pane) then
          window:perform_action(
            act.Multiple({
              act.SendKey({ key = "w", mods = "CTRL" }),
              act.SendKey({ key = "k" }),
            }),
            pane
          )
        else
          window:perform_action(act.ActivatePaneDirection("Up"), pane)
        end
      end),
    },
    {
      key = "l",
      mods = "LEADER",
      action = wezterm.action_callback(function(window, pane)
        if is_inside_vim(pane) then
          window:perform_action(
            act.Multiple({
              act.SendKey({ key = "w", mods = "CTRL" }),
              act.SendKey({ key = "l" }),
            }),
            pane
          )
        else
          window:perform_action(act.ActivatePaneDirection("Right"), pane)
        end
      end),
    },
    table.unpack(config.keys),
  }
end

return config
