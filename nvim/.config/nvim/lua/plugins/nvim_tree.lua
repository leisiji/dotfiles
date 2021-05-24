local M = {}
NVIM_TREE_TOGGLE_RESIZE = false

local function resize(size)
  local nvim_tree = require'nvim-tree'
  require'nvim-tree.view'.View.width = size
  nvim_tree.close()
  nvim_tree.open()
end

function M.resize_toggle()
  if NVIM_TREE_TOGGLE_RESIZE then
    resize(30)
    NVIM_TREE_TOGGLE_RESIZE = false
  else
    resize(70)
    NVIM_TREE_TOGGLE_RESIZE = true
  end
end

function M.config()
  vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 0 }
  local tree_cb = require'nvim-tree.config'.nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    ["l"]     = tree_cb("edit"),
    ["<CR>"]  = tree_cb("cd"),
    ["v"]     = tree_cb("vsplit"),
    ["s"]     = tree_cb("split"),
    ["t"]     = tree_cb("tabnew"),
    ["h"]     = tree_cb("close_node"),
    ["p"]     = tree_cb("preview"),
    ["."]     = tree_cb("toggle_dotfiles"),
    ["R"]     = tree_cb("refresh"),
    ["a"]     = tree_cb("create"),
    ["D"]     = tree_cb("remove"),
    ["r"]     = tree_cb("rename"),
    ["<BS>"]  = tree_cb("dir_up"),
    ["q"]     = tree_cb("close"),
  }

  require'nvim-tree.events'.on_nvim_tree_ready(function ()
    vim.cmd("NvimTreeRefresh")
  end)
end

return M
