-- Reference to lsp-status.nvim
local M = {}
local lsp_util = require('vim.lsp.util')

local function get_current_func(items, row)
  if type(items) ~= 'table' then
    return
  end

  for _, item in ipairs(items) do
    local sym_range = nil
    if item.location then -- Item is a SymbolInformation
      sym_range = item.location.range
    elseif item.range then -- Item is a DocumentSymbol
      sym_range = item.range
    end

    local start_line = sym_range.start.line
    local end_line = sym_range['end'].line

    if sym_range ~= nil then
      if row >= start_line and row <= end_line then
        local kind = item.kind
        -- "rust mod" and "rust impl" and "cpp namespace"
        if kind == 2 or kind == 3 or kind == 19 then
          return get_current_func(item.children, row)
        else
          return item.name
        end
      end
    end
  end
  return ""
end

local function current_fun_cb(_, result, _, _)
  vim.b.current_func_name =  ''

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  vim.b.current_func_name = get_current_func(result, cursor_pos[1])
end

function M.update()
  local params = { textDocument = lsp_util.make_text_document_params() }
  vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, current_fun_cb)
end

return M
