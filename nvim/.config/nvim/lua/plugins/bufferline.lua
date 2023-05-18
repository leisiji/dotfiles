local M = {}

function M.config()
  require("bufferline").setup({
    options = {
      mode = "tabs",
      name_formatter = function(buf)
        return buf.name
      end,
    },
  })
end

return M
