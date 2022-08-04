local M = {}
local original_width = nil

function M.setup()
  local list = {
    { key = "l", action = "edit" },
    { key = "h", action = "close_node" },
    { key = "<C-]>", action = "cd" },
    { key = "<C-[>", action = "dir_up" },
    { key = "<C-v>", action = "vsplit" },
    { key = "<C-t>", action = "tabnew" },
    { key = ".", action = "toggle_dotfiles" },
    { key = "R", action = "refresh" },
    { key = "a", action = "create" },
    { key = "D", action = "remove" },
    { key = "r", action = "rename" },
    { key = "x", action = "cut" },
    { key = "c", action = "copy" },
    { key = "p", action = "paste" },
    { key = "y", action = "copy_name" },
    { key = "Y", action = "copy_path" },
    { key = "gy", action = "copy_absolute_path" },
    { key = "q", action = "close" },
    { key = "<M-k>", action = "toggle_file_info" },
    { key = "z", cb = [[:lua require('plugins.nvim_tree').resize()<cr>]] },
    { key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
  }
  require("nvim-tree").setup({
    view = {
      width = 35,
      mappings = { custom_only = true, list = list }
    },
    git = {
      enable = false,
    },
    renderer = {
      highlight_git = false,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
        },
      },
    },
    actions = {
      open_file = {
        quit_on_open = true,
        resize_window = true,
      },
      change_dir = {
        enable = false,
      },
    },
  })
end

function M.resize()
  local w = require("nvim-tree.view").View.width
  if original_width == nil then
    original_width = w
  end
  if w ~= original_width then
    w = original_width
  else
    w = w + 50
  end
  require("nvim-tree.view").View.width = w
  vim.cmd("NvimTreeClose")
  vim.cmd("NvimTreeToggle")
end

return M
