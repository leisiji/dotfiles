local M = {}

function M.setup()
	vim.g.completion_enable_snippet = 'vim-snip'
	vim.g.completion_matching_smart_case = 1
	vim.g.completion_trigger_keyword_length = 2
	vim.g.completion_timer_cycle = 500
	vim.g.completion_matching_strategy_list = { 'fuzzy' }
	vim.g.completion_items_priority = {
		Field = 5, Function = 7, Variables = 7, Method = 10, Interfaces = 5,
		Constant = 5, Class = 5, Keyword = 4, Buffers = 1, File = 0,
		['vim-snip'] = 8
	}
	vim.g.completion_trigger_character = {'.', '::'}
end

function M.config()
	require('completion').on_attach()

	vim.api.nvim_exec([[
		augroup completion_config
			autocmd!
			autocmd BufEnter * lua require'completion'.on_attach()
		augroup END
	]], false)

	vim.g.completion_chain_complete_list = {
		default = {
			{ complete_items = { 'lsp', 'buffers', 'snippet' } },
			{ mode = { '<c-p>' } },
			{ mode = { '<c-n>' } }
		}
	}
end

return M
