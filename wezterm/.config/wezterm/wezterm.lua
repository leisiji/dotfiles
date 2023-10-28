local wezterm = require 'wezterm';

return {
  font = wezterm.font_with_fallback({"FiraCode Nerd Font", "WenQuanYi Micro Hei"}),
  font_size = 10.0,
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
  --window_frame = {
  --    border_left_width = '0.1cell',
  --    border_right_width = '0.1cell',
  --    border_bottom_height = '0.1cell',
  --    border_top_height = '0.1cell',
  --    border_left_color = 'grey',
  --    border_right_color = 'grey',
  --    border_bottom_color = 'grey',
  --    border_top_color = 'grey',
  --},
  force_reverse_video_cursor = true,
  colors = {
    foreground = "#dcd7ba",
    background = "#1f1f28",

    cursor_bg = "#c8c093",
    cursor_fg = "#c8c093",
    cursor_border = "#c8c093",

    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",

    scrollbar_thumb = "#16161d",
    split = "#16161d",

    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
  },
}
