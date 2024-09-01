local M = {}

function M.config()
  local opts = {
    general = {
      enable = function(buf, win)
        return vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" and not vim.wo[win].diff
      end,
      update_interval = 500,
      update_events = {
        win = {
          "CursorHold",
          "WinEnter",
          "WinResized",
        },
        buf = {
          "CursorHold",
          "TextChanged",
          "TextChangedI",
        },
        global = {
          "DirChanged",
          "VimResized",
        },
      },
    },
    menu = {
      preview = false,
      keymaps = {
        ["l"] = function()
          local menu = require("dropbar.utils.menu").get_current()
          if not menu then
            return
          end
          local cursor = vim.api.nvim_win_get_cursor(menu.win)
          local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
          if component then
            menu:click_on(component, nil, 1, "l")
          end
        end,
        ["q"] = function()
          vim.cmd("q")
        end,
      },
    },
  }
  require("dropbar").setup(opts)

  vim.keymap.set("n", "<leader>i", function()
    local bar = require("dropbar.utils.bar")
    local b = bar.get_current()
    local f = vim.fn.expand("%:t")
    if b == nil then
      return
    end
    for i, component in ipairs(b.components) do
      if component.name == f then
        b:pick(i)
        return
      end
    end
  end, { noremap = true, silent = true })
end

return M
