local M = {}

function M.filter(name)
  local suffixes = { ".o", ".ko", ".so", ".a", ".cmd" }
  for _, suffix in ipairs(suffixes) do
    if name:sub(-#suffix) == suffix then
      return true
    end
  end
  return false
end

return M
