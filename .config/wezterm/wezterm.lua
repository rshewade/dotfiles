local wezterm = require("wezterm")
local config = wezterm.config_builder()

--General
config.font_size = 13
config.line_height = 1.2
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.color_scheme = "Gruvbox dark, soft (base16)"

-- Tabs at bottom
config.tab_bar_at_bottom = false
config.window_frame = {
  font_size = 16.0,
}

-- Semi-transparent background
config.window_background_opacity = 0.90
config.macos_window_background_blur = 20

return config
