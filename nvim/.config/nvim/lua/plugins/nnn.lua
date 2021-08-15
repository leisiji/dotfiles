local M = {}

function M.setup()
  vim.g['nnn#session'] = 'global'
  require("nnn").setup({
    command = "nnn -o",
    set_default_mappings = 0,
    replace_netrw = 1,
    action = {
        ["<c-t>"] = "tab split",
        ["<c-s>"] = "split",
        ["<c-v>"] = "vsplit"
    },
  })
end

return M
