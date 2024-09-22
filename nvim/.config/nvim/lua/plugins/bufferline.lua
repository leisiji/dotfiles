local M = {}

function M.config()
  require("bufferline").setup({
    options = {
      mode = "tabs",
      numbers = function(opts)
        return string.format("%s", opts.ordinal)
      end,
    },
  })
end

return M
