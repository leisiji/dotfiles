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
  enable_wayland = false,
  mouse_bindings = {
    {
      event = { Up = { streak=2, button="Left" } },
      mods = "NONE",
      action = wezterm.action{ CopyTo="ClipboardAndPrimarySelection" }
    }
  }
}
