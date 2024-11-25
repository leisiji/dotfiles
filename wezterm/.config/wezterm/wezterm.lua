local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

return {
  font = wezterm.font_with_fallback({ "CaskaydiaCove Nerd Font" }),
  font_size = 10.0,
  color_scheme = "Kanagawa (Gogh)",
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
      event = { Up = { streak = 2, button = "Left" } },
      mods = "NONE",
      action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
    },
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action({ CompleteSelectionOrOpenLinkAtMouseCursor = "Clipboard" }),
    },
  },
}
