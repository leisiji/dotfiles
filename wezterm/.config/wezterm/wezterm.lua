local wezterm = require 'wezterm';

return {
  font = wezterm.font_with_fallback({"CaskaydiaCove Nerd Font Mono", "WenQuanYi Micro Hei"}),
  font_size = 13.0,
  color_scheme = "GitHub Dark",
  enable_tab_bar = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  use_ime = true,
  mouse_bindings = {
    {
      event = { Up = { streak=2, button="Left" } },
      mods = "NONE",
      action = wezterm.action{ CopyTo="ClipboardAndPrimarySelection" }
    },
    {
      event={Up={streak=1, button="Left"}},
      mods="NONE",
      action=wezterm.action{CompleteSelectionOrOpenLinkAtMouseCursor="Clipboard"},
    },
  },
  window_decorations = "NONE",
  window_frame = {
      border_left_width = '0.1cell',
      border_right_width = '0.1cell',
      border_bottom_height = '0.1cell',
      border_top_height = '0.1cell',
      border_left_color = 'grey',
      border_right_color = 'grey',
      border_bottom_color = 'grey',
      border_top_color = 'grey',
  },
}
