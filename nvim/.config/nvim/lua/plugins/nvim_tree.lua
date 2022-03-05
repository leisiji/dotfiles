local M = {}
local original_width = nil

function M.setup()
  vim.g.nvim_tree_git_hl = 0
  vim.g.nvim_tree_show_icons = { git = 0, folders = 1, folder_arrows = 1 }
  local list = {
    { key = "l", action = "edit" },
    { key = "h", action = "close_node" },
    { key = "<C-]>", action = "cd" },
    { key = "<C-[>", action = "dir_up" },
    { key = "<C-v>", action = "vsplit" },
    { key = "<C-x>", action = "split" },
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
    { key = "<M-k>", action = 'show_file_info' },
    { key = "z", cb = [[:lua require('plugins.nvim_tree').resize()<cr>]] },
  }
  require("nvim-tree").setup({
    view = { mappings = { custom_only = true, list = list } },
    git = {
      enable = false,
    },
    actions = {
      open_file = {
        quit_on_open = true,
        resize_window = true,
      }
    }
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
