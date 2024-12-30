local M = {}

function M.config()
  -- Lua configuration
  local glance = require("glance")
  local actions = glance.actions

  glance.setup({
    folds = {
      folded = false,
    },
    preview_win_opts = {
      number = false,
    },
    height = 50,
    border = {
      enable = true,
    },
    mappings = {
      list = {
        ["<M-k>"] = actions.preview_scroll_win(5), -- Scroll up the preview window
        ["<M-j>"] = actions.preview_scroll_win(-5), -- Scroll down the preview window
        ["<C-v>"] = actions.jump_vsplit, -- Open location in vertical split
        ["<C-s>"] = actions.jump_split, -- Open location in horizontal split
        ["<C-t>"] = actions.jump_tab, -- Open in new tab
        ["<M-a>"] = actions.enter_win("preview"), -- Focus preview window
      },
      preview = {
        ["<leader>l"] = actions.enter_win("list"), -- Focus list window
      },
    },
  })
end

return M
