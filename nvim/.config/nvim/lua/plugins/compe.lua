local M = {}
local fn = vim.fn

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = fn.col('.') - 1
	if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

_G.tab_complete = function()
	if fn.pumvisible() == 1 then
		return t "<C-n>"
	elseif fn.call("vsnip#available", {1}) == 1 then
		return t "<Plug>(vsnip-expand-or-jump)"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return vim.fn['compe#complete']()
	end
end

_G.s_tab_complete = function()
	if fn.pumvisible() == 1 then
		return t "<C-p>"
	elseif fn.call("vsnip#jumpable", {-1}) == 1 then
		return t "<Plug>(vsnip-jump-prev)"
	else
		return t "<S-Tab>"
	end
end

function M.config()
	require'compe'.setup {
		enabled = true;
		autocomplete = true;
		debug = false;
		min_length = 1;
		preselect = 'enable';
		throttle_time = 80;
		source_timeout = 200;
		incomplete_delay = 400;
		max_abbr_width = 100;
		max_kind_width = 100;
		max_menu_width = 100;
		documentation = true;

		source = {
			path = true;
			buffer = true;
			calc = false;
			nvim_lsp = true;
			nvim_lua = true;
			vsnip = true;
			ultisnips = false;
		};
	}
end

return M
