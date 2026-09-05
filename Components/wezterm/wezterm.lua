local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Platform
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil

-- Shell
if is_windows then
    config.default_prog = { "pwsh.exe", "-NoLogo" }
elseif is_linux then
    config.default_prog = { "/bin/bash", "-l" }
end

-- Appearance
config.font = wezterm.font("JetBrainsMono NF")
config.font_size = 13
config.color_scheme = "Tokyo Night Storm"

-- Window
config.window_decorations = "TITLE|RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true
config.enable_scroll_bar = false
config.initial_rows = 30
config.initial_cols = 125

config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

config.tab_max_width = 32
config.adjust_window_size_when_changing_font_size = false

-- Behaviour
config.audible_bell = "Disabled"

-- Launch Menu
config.launch_menu = {
    {
        label = "PowerShell",
        args = { "pwsh.exe", "-NoLogo" },
    },
    {
        label = "Windows PowerShell",
        args = { "powershell.exe", "-NoLogo" },
    },
    {
        label = "Command Prompt",
        args = { "cmd.exe" },
    },
}

-- Keybindings
config.keys = {
    {
        key = "r",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ReloadConfiguration,
    },
}

return config