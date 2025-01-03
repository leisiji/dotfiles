local M = {}

local function is_absolute(path)
  if vim.uv.os_uname().sysname == "Windows_NT" then
    return path:match("^%a:[/\\]") or path:match("^//") or path:match("^\\\\")
  else
    return path:sub(1, 1) == "/"
  end
end

local function on_exit(obj)
  print(obj.stdout)
end

function M.goto_error()
  local linenum = unpack(vim.api.nvim_win_get_cursor(0))
  local errors = require("compile-mode.errors")
  local error = errors.error_list[linenum]
  local current_dir = vim.fn.getcwd()
  current_dir = string.gsub(current_dir, "/$", "")
  local fname = error.filename.value
  if not is_absolute(fname) then
    fname = current_dir .. "/" .. fname
  end
  local file_exists = vim.fn.filereadable(fname) ~= 0
  if file_exists then
    vim.api.nvim_exec2("tab CompileGotoError", { output = false })
    return
  end
  vim.system({ "fd", vim.fn.fnamemodify(fname, ":t") }, { text = true }, on_exit)
end

return M
