-- Pull down the Wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Set PowerShell to default shell on load
config.default_prog = {"powershell.exe"}

-- Set Appearance
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14
config.colors = {
	cursor_bg = "F2F3F4",
	cursor_border = "F2F3F4",
	background = "#1A1C24"
}
-- config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}
config.initial_rows = 30
config.initial_cols = 125

config.default_cursor_style = "BlinkingBlock"

return config