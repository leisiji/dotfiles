local M = {}

function M.config()
  require("bufferline").setup({
    options = {
      mode = "tabs",
      buffer_close_icon = "",
      name_formatter = function(buf)
        return buf.name
      end,
      numbers = function(opts)
        return string.format("%s", opts.ordinal)
      end,
    },
  })
end

return M
