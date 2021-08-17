local M = {}

local clang_format = function ()
  return {
    exe =  'clang-format',
    args = { '--style=file' },
    stdin = true
  }
end

function M.config()
  require('formatter').setup({
    logging = false,
    filetype = {
      c = {
        clang_format
      },
      cpp = {
        clang_format
      },
      java = {
        function ()
          return {
            exe = 'google-java-format',
            args = { '-i', '-a' },
            stdin = false
          }
        end
      },
    }
  })
end

return M
