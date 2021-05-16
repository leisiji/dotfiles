local M = {}
local lsp, api, fn = vim.lsp, vim.api, vim.fn
local utils = require('fzf_utils.utils')

-- transform function
local function lsp_to_vimgrep(result)
	local targetLoc = result.targetRange.start
	local path = fn.fnamemodify(vim.uri_to_fname(result.targetUri), ':.')
	return string.format('%s:%d:%d', path, targetLoc.line + 1, targetLoc.character + 1)
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
local function lsp_handle(m, result)
	if result == nil then
		print(m .. 'not found!')
		return nil
	end

	local choice

	if #result == 1 then
		choice = lsp_to_vimgrep(result[1])
	else
		local res = {}
		local count = 1
		for _, item in pairs(result) do
			res[count] = lsp_to_vimgrep(item)
			count = count + 1
		end
		local choices = require('fzf').fzf(res, utils.vimgrep_preview)
		choice = choices[2]
	end

	return choice
end

function M.jump_to_definition(action)
	coroutine.wrap(function ()
		local m = "textDocument/definition"
		local r = lsp.buf_request_sync(0, m, lsp.util.make_position_params(), 1000)
		local c = lsp_handle(m, r[1].result)
		if c ~= nil then
			jump_to_buffer(c, action)
		end
	end)()
end

return M
