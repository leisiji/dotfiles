local M = {}

function M.config()
  -- Lua configuration
  local glance = require("glance")
  local actions = glance.actions

  glance.setup({
    height = 25,
    border = {
      enable = true,
      top_char = "-",
      bottom_char = "-",
    },
    list = {
      position = "right",
      width = 0.33,
    },
    theme = {
      enable = true,
      mode = "auto",
    },
    mappings = {
      list = {
        ["<Tab>"] = actions.next_location,
        ["<S-Tab>"] = actions.previous_location,
        ["<M-k>"] = actions.preview_scroll_win(5),
        ["<M-j>"] = actions.preview_scroll_win(-5),
        ["<C-v>"] = actions.jump_vsplit,
        ["<C-s>"] = actions.jump_split,
        ["<C-t>"] = actions.jump_tab,
        ["<l>"] = actions.jump,
        ["o"] = actions.jump,
        ["<leader>l"] = actions.enter_win("preview"),
        ["q"] = actions.close,
        ["Q"] = actions.close,
        ["<Esc>"] = actions.close,
      },
      preview = {
        ["Q"] = actions.close,
        ["<Tab>"] = actions.next_location,
        ["<S-Tab>"] = actions.previous_location,
        ["<leader>l"] = actions.enter_win("list"),
      },
    },
    folds = {
      fold_closed = "",
      fold_open = "",
      folded = false,
    },
    indent_lines = {
      enable = true,
      icon = "│",
    },
    winbar = {
      enable = true,
    },
  })
end

return M
