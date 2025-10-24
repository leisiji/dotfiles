local M = {}

-- Configuration defaults
local config = {
  min_width = 20,
  max_width = vim.o.columns - 10,
  padding = 5,
  include_extmarks = true,
  exclude_filetypes = {
    "NvimTree",
    "toggleterm",
    "alpha",
    "dashboard",
    "minifiles",
    "grug-far",
    "Outline",
    "help",
  },
}

-- Set custom configuration
function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
end

-- Get display width of a line considering multibyte characters
local function get_display_width(line)
  return vim.fn.strdisplaywidth(line)
end

-- Get all extmarks that might affect line width
local function get_relevant_extmarks(bufnr, line_num)
  local extmarks = {}
  local namespaces = vim.api.nvim_get_namespaces()

  for ns_name, ns_id in pairs(namespaces) do
    local marks = vim.api.nvim_buf_get_extmarks(
      bufnr,
      ns_id,
      {line_num, 0},
      {line_num, -1},
      {details = true}
    )

    for _, mark in ipairs(marks) do
      local mark_info = mark[4]
      -- Check if this extmark affects display
      if mark_info.virt_text or mark_info.virt_text_pos then
        table.insert(extmarks, mark_info)
      end
    end
  end

  return extmarks
end

-- Calculate effective line width including extmarks
local function calculate_effective_line_width(bufnr, line_num, line_text)
  local base_width = get_display_width(line_text)
  local extmarks = get_relevant_extmarks(bufnr, line_num)
  local additional_width = 0

  for _, extmark in ipairs(extmarks) do
    if extmark.virt_text then
      for _, text_chunk in ipairs(extmark.virt_text) do
        additional_width = additional_width + get_display_width(text_chunk[1])
      end
    end
  end

  return base_width + additional_width
end

-- Get the longest line in the current buffer
function M.get_longest_line_length()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype

  -- Skip excluded filetypes
  for _, ft in ipairs(config.exclude_filetypes) do
    if ft == filetype then
      return nil
    end
  end

  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local max_width = 0
  local longest_line_num = 1

  -- Only check visible range for large buffers to improve performance
  local start_line, end_line
  if line_count > 10000 then
    local win_info = vim.fn.winsaveview()
    start_line = math.max(1, win_info.topline)
    end_line = math.min(line_count, win_info.topline + vim.fn.winheight(0) * 2)
  else
    start_line = 1
    end_line = line_count
  end

  for line_num = start_line, end_line do
    local line_text = vim.api.nvim_buf_get_lines(bufnr, line_num - 1, line_num, false)[1] or ""
    local effective_width

    if config.include_extmarks then
      effective_width = calculate_effective_line_width(bufnr, line_num - 1, line_text)
    else
      effective_width = get_display_width(line_text)
    end

    if effective_width > max_width then
      max_width = effective_width
      longest_line_num = line_num
    end
  end

  return max_width, longest_line_num
end

-- Auto-adjust window width based on longest line
function M.auto_adjust_width()
  local longest_length = M.get_longest_line_length()

  if not longest_length then
    vim.notify("Auto width: filetype excluded", vim.log.levels.INFO)
    return
  end

  if longest_length == 0 then
    vim.notify("Auto width: empty buffer", vim.log.levels.INFO)
    return
  end

  -- Apply padding and constraints
  local target_width = longest_length + config.padding
  target_width = math.max(config.min_width, target_width)
  target_width = math.min(config.max_width, target_width)

  local current_width = vim.api.nvim_win_get_width(0)

  -- Only adjust if there's a meaningful difference
  if math.abs(target_width - current_width) > 2 then
    vim.api.nvim_win_set_width(0, target_width)

    local message = string.format(
      "Window width: %d → %d (longest line: %d chars)",
      current_width,
      target_width,
      longest_length
    )
    vim.notify(message, vim.log.levels.INFO)
  else
    vim.notify("Window width already optimal", vim.log.levels.INFO)
  end
end

-- Toggle between original and auto-adjusted width
function M.toggle_auto_width()
  if vim.w.auto_width_original then
    -- Restore original width
    vim.api.nvim_win_set_width(0, vim.w.auto_width_original)
    vim.w.auto_width_original = nil
  else
    -- Save current width and auto-adjust
    vim.w.auto_width_original = vim.api.nvim_win_get_width(0)
    M.auto_adjust_width()
  end
end

return M
