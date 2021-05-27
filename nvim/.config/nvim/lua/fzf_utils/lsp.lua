local M = {}
local lsp, api, fn = vim.lsp, vim.api, vim.fn
local utils = require('fzf_utils.utils')
local a = require('plenary.async_lib')
local request = require('plenary.async_lib.lsp').buf_request_all

-- transform function
local function lsp_to_vimgrep(r)
  local range = r.range or r.targetRange
  local uri = r.uri or r.targetUri
  local loc = range.start
  local path = fn.fnamemodify(vim.uri_to_fname(uri), ':.')
  return string.format('%s:%d:%d', path, loc.line + 1, loc.character + 1)
end

local function jump_to_buffer(grep, action)
  local res = { string.match(grep, "(.-):(%d+):(%d+)") }
  local path = res[1]

  if action ~= 'edit' or fn.bufloaded(fn.bufnr(path)) ~= 1 then
    vim.cmd(string.format('%s %s', action, res[1]))
  end

  api.nvim_win_set_cursor(0, {tonumber(res[2]), tonumber(res[3])})
  vim.cmd("normal! zz")
end

-- core function for finding def or ref
local function lsp_handle(ret, action)
  local c
  local res = {}

  for _, v in pairs(ret) do
    if v.result ~= nil then
      for _, item in pairs(v.result) do
        res[#res+1] = lsp_to_vimgrep(item)
      end
    else
      res[#res+1] = lsp_to_vimgrep(v)
    end
  end

  if #res == 1 then
    c = res[1]
    jump_to_buffer(c, action)
  else
    coroutine.wrap(function ()
      local choices = require('fzf').fzf(res, utils.vimgrep_preview)
      if choices[1] == 'ctrl-v' then a = 'vsplit' end
      jump_to_buffer(choices[2], a)
    end)()
  end
end

local function lsp_fzf(method, action)
  a.async_void(function ()
    local r = a.await(request(0, method, lsp.util.make_position_params()))
    if r == nil then
      print(method + 'not found')
    else
      lsp_handle(r, action)
    end
  end)()
end

function M.definition(action)
  lsp_fzf('textDocument/definition', action or 'edit')
end

function M.references(action)
  lsp_fzf('textDocument/references', action or 'edit')
end

return M
