local M = {}

function M.config()
  local config = {
    ensure_newline = function()
      return true
    end,
  }
  if vim.env.TERMUX_APP_PID then
    config.create_tmp_filepath = function(filetype)
      return vim.fn.stdpath("cache") .. "femaco"
    end
  end
  require("femaco").setup(config)
end

return M
