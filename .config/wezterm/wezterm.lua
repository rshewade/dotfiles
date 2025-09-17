local wezterm = require("wezterm")
local config = wezterm.config_builder()

--General
config.font_size = 17
config.line_height = 1.2
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.color_scheme = "Gruvbox dark, soft (base16)"



return config
