local M = {}

function M.config()
  -- Lua configuration
  local glance = require("glance")
  local actions = glance.actions

  glance.setup({
    folds = {
      folded = false,
    },
    detached = true,
    preview_win_opts = {
      number = false,
    },
    height = 40,
    border = {
      enable = true,
      top_char = "─",
      bottom_char = "─",
    },
    mappings = {
      list = {
        ["<M-k>"] = actions.preview_scroll_win(5),
        ["<M-j>"] = actions.preview_scroll_win(-5),
        ["<C-v>"] = actions.jump_vsplit,
        ["<C-s>"] = actions.jump_split,
        ["<C-t>"] = actions.jump_tab,
        ["<M-a>"] = actions.enter_win("preview"),
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
      preview = {
        ["<M-a>"] = actions.enter_win("list"),
        ["q"] = actions.close,
      },
    },
  })
end

return M
