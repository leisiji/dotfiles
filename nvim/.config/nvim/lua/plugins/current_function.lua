-- Reference to lsp-status.nvim
local M = {}
local lsp_util = require('vim.lsp.util')

local function current_fun_cb(_, _, result, _, _)
  vim.b.current_func_name =  ''

  if type(result) ~= 'table' then
    return
  end

  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  for _, item in ipairs(result) do
    local sym_range = nil
    if item.location then -- Item is a SymbolInformation
      sym_range = item.location.range
    elseif item.range then -- Item is a DocumentSymbol
      sym_range = item.range
    end

    local line = cursor_pos[1]
    local start_line = sym_range.start.line
    local end_line = sym_range['end'].line

    if sym_range ~= nil then
      if line >= start_line and line <= end_line then
        vim.b.current_func_name = item.name
        break
      end
    end
  end
end

function M.update()
  local params = { textDocument = lsp_util.make_text_document_params() }
  vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, current_fun_cb)
end

return M
