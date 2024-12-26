local M = {}

local function filter(name)
  if name:sub(1, 1) == "." then
    return true
  end

  local suffixes = { ".o", ".ko", ".so", ".a", ".cmd", ".order", ".symvers" }
  for _, suffix in ipairs(suffixes) do
    if name:sub(-#suffix) == suffix then
      return true
    end
  end
  return false
end

local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify("Cursor is not on valid entry")
  end
  vim.fn.chdir(vim.fs.dirname(path))
  MiniFiles.close()
end

function M.config()
  require("mini.files").setup({
    content = {
      filter = function(res)
        return filter(res.name) ~= true
      end,
    },
    windows = {
      preview = true,
    },
    mappings = {
      go_in = "L",
      go_in_plus = "l",
    },
  })

  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. " split")
        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)
      MiniFiles.go_in({ close_on_file = true })
    end
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id })
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      map_split(buf_id, "<C-s>", "belowright horizontal")
      map_split(buf_id, "<C-v>", "belowright vertical")
      map_split(buf_id, "<C-t>", "belowright tab")
      vim.keymap.set("n", "<C-c>", set_cwd, { buffer = buf_id })
    end,
  })
end

return M
