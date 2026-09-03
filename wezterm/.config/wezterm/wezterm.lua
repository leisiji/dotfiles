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
config.tab_bar_at_bottom = true

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

local reize_keytable = act.ActivateKeyTable({
  name = "resize_pane",
  one_shot = false,
  timeout_milliseconds = 1000,
  -- timeout_action = act.PopKeyTable,
})

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
    mods = "ALT",
    action = act.QuickSelectArgs,
  },
  { key = "r", mods = "LEADER", action = reize_keytable },
  { key = "x", mods = "ALT", action = act.ActivateCopyMode },
}

-- 将单个 CopyMode 动作重复 n 次（如 5w / 5b / 5e）
local function repeat_copymode(action_name, n)
  local actions = {}
  for _ = 1, n do
    table.insert(actions, act.CopyMode(action_name))
  end
  return act.Multiple(actions)
end

config.key_tables = {
  copy_mode = {
    { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
    { key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
    { key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
    { key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
    { key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
    { key = "w", mods = "ALT", action = repeat_copymode("MoveForwardWord", 5) },
    { key = "b", mods = "ALT", action = repeat_copymode("MoveBackwardWord", 5) },
    { key = "e", mods = "ALT", action = repeat_copymode("MoveForwardWordEnd", 5) },
    { key = "H", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLine") },
    { key = "L", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
    { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
    { key = "u", mods = "CTRL", action = act.CopyMode("PageUp") },
    { key = "d", mods = "CTRL", action = act.CopyMode("PageDown") },
    { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
    {
      key = "y",
      mods = "NONE",
      action = act.Multiple({
        { CopyTo = "ClipboardAndPrimarySelection" },
        { CopyMode = "Close" },
      }),
    },
    { key = "q", mods = "NONE", action = act.CopyMode("Close") },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    { key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "n", mods = "NONE", action = act.CopyMode("NextMatch") },
    { key = "N", mods = "SHIFT", action = act.CopyMode("PriorMatch") },
  },
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },
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
