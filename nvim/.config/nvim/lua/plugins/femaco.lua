local M = {}

function M.config()
  require("femaco").setup({
    ensure_newline = function ()
      return true
    end
  })
end

return M
