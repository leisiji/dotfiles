local M = {}

local function filter(name)
  local suffixes = { ".o", ".ko", ".so", ".a", ".cmd" }
  for _, suffix in ipairs(suffixes) do
    if name:sub(-#suffix) == suffix then
      return true
    end
  end
  return false
end

function M.config()
  local map_mini = function(buf_id, lhs, direction)
    local rhs = function()
      -- Make new window and set it as target
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction)
        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)
    end

    -- Adding `desc` will result into `show_help` entries
    local desc = "Split " .. direction
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak keys to your liking
      map_mini(buf_id, "<C-s>", "belowright horizontal split")
      map_mini(buf_id, "<C-v>", "belowright vertical split")
      map_mini(buf_id, "<C-t>", "tabe")
    end,
  })
  require("mini.files").setup({
    content = {
      filter = function(res)
        return filter(res.name) ~= true
      end,
    },
    windows = {
      preview = true,
    },
  })
end

return M
