local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local is_windows = wezterm.target_triple:find("windows") ~= nil

local function has_executable(name)
  local path_env = os.getenv("PATH") or ""
  for path in string.gmatch(path_env, "[^;]+") do
    local filepath = path .. "\\" .. name
    local f = io.open(filepath, "r")
    if f then
      f:close()
      return true
    end
    if not name:match("%.exe$") then
      local f_exe = io.open(filepath .. ".exe", "r")
      if f_exe then
        f_exe:close()
        return true
      end
    end
  end
  return false
end

config.leader = { key = "n", mods = "ALT", timeout_milliseconds = 2000 }
config.use_fancy_tab_bar = false

config.colors = {
  tab_bar = {
    background = "#0b0022",
    active_tab = {
      bg_color = "#2b2042",
      fg_color = "#c0c0c0",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = "#1b1032",
      fg_color = "#808080",
    },
    inactive_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = true,
    },
    new_tab = {
      bg_color = "#1b1032",
      fg_color = "#808080",
    },
    new_tab_hover = {
      bg_color = "#3b3052",
      fg_color = "#909090",
      italic = true,
    },
  },
}

wezterm.on("update-right-status", function(window, _)
  local date = wezterm.strftime("%Y-%m-%d %H:%M")
  window:set_right_status(date)
end)

config.font = wezterm.font_with_fallback({ "Maple Mono NF CN" })
config.font_size = 9.0
config.color_scheme = "Kanagawa (Gogh)"
config.enable_tab_bar = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.use_ime = true
config.pane_focus_follows_mouse = true

config.quick_select_patterns = {
  "[\\w./-]+",
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 2, button = "Left" } },
    mods = "NONE",
    action = act.CopyTo("ClipboardAndPrimarySelection"),
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor("Clipboard"),
  },
}

if is_windows and has_executable("nu") then
  config.default_prog = { "nu" }
end


config.keys = {
  {
    key = "a",
    mods = "LEADER|CTRL",
    action = act.SendKey({ key = "a", mods = "CTRL" }),
  },
  {
    key = "c",
    mods = "LEADER",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "x",
    mods = "LEADER",
    action = act.CloseCurrentPane({ confirm = false }),
  },
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "enter new tab name：",
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
  {
    key = "_",
    mods = "LEADER|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "m",
    mods = "ALT",
    action = act.ActivateLastTab,
  },
  {
    key = "p",
    mods = "ALT",
    action = act.ActivatePaneDirection("Next"),
  },
  {
    key = "z",
    mods = "LEADER",
    action = act.TogglePaneZoomState,
  },
  {
    key = "h",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = ".",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "移动 Tab 到指定位置 (1-9)：",
      action = wezterm.action_callback(function(window, pane, line)
        local idx = tonumber(line)
        if idx and idx > 0 then
          -- MoveTab 接收从 0 开始的索引，故减 1
          window:perform_action(act.MoveTab(idx - 1), pane)
        end
      end),
    }),
  },
  {
    key = "i",
    mods = "ALT", -- 修改为你想要的组合键
    action = act.QuickSelectArgs,
  },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

local domains = wezterm.default_ssh_domains()

for _, dom in ipairs(domains) do
  dom.multiplexing = "WezTerm"
  dom.remote_wezterm_path = "~/wezterm-mux-server"
end

config.ssh_domains = domains

return config
