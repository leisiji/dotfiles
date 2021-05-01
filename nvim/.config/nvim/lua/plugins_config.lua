local config = {}

-- galaxyline
COLORS = require('galaxyline.theme').default
VI_MODES = {
	n = { COLORS.red,   '  NORMAL ' },
	i = { COLORS.green, '  INSERT ' },
	v = { COLORS.blue,  '  VISUAL ' },
	V = { COLORS.blue,  '  V-LINE ' },
	[''] = { COLORS.blue, '  VISUAL ' },
	c = { COLORS.violet, '  COMMAND ' },
	t = { COLORS.yellow, '  TERMINAL ' },
}

function config.statusline()
	local galaxyline = require('galaxyline')
	local section = galaxyline.section

	section.left[1] = {
		ViMode = {
			provider = function()
				local mode = VI_MODES[vim.fn.mode()]
				if mode ~= nil then
					vim.api.nvim_command('hi GalaxyViMode guibg='..mode[1])
					return mode[2]
				end
			end,
			highlight = {COLORS.bg, COLORS.bg, 'bold'}
		}
	}
	section.left[2] = {
		CocFunc = {
			provider = {
				function()
					local has_func, func_name =
						pcall(vim.api.nvim_buf_get_var, 0, 'coc_current_function')
					if not has_func then return end
					return func_name
				end
			},
			icon = '  λ ',
			separator_highlight = { COLORS.yellow, COLORS.bg },
			highlight = { COLORS.yellow, COLORS.bg },
		}
	}
	section.right[1] = {
		BufferType = {
			provider = 'FileTypeName',
			separator = ' | ',
		}
	}
	section.right[2] = {
		MaxLine = {
			provider = function ()
				return 'ln '..vim.fn.line('$')..' '
			end,
			separator = ' | ',
		}
	}

	galaxyline.load_galaxyline()
end

-- treesitter
function config.treesitter()
	require'nvim-treesitter.configs'.setup {
		ensure_installed = "maintained",
		highlight = {
			enable = true,
		}
	}
end

-- gitsigns
function config.gitsigns()
	require'gitsigns'.setup {
		signs = {
			add = {hl = 'GitGutterAdd', text = '+'},
			change = {hl = 'GitGutterChange', text = '~'},
			delete = { hl = 'GitGutterDelete', text = '_'},
			topdelete = { hl = 'GitGutterDelete', text = '‾'},
			changedelete = { hl = 'GitGutterChange', text = '~' }
		},
		watch_index = {
			interval = 5000
		},
		keymaps = {
			noremap = true,
			buffer = true,
			['n <leader><leader>n'] = '<cmd>lua require"gitsigns".next_hunk()<CR>',
			['n <leader><leader>N'] = '<cmd>lua require"gitsigns".prev_hunk()<CR>',
			['n <leader><leader>b'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
		}
	}
end

function config.colorscheme()
	function _G.mytabline()
		local fn = vim.fn
		local pagenum = fn.tabpagenr('$')
		local s = ''
		local i = 1
		while i <= pagenum  do
			if i == fn.tabpagenr() then
				s = s..'%#TabLineSel#'
			else
				s = s..'%#TabLine#'
			end
			s = s .. ' ' .. tostring(i) .. '.'
			local bufnr = fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
			local path = fn.bufname(bufnr)
			s = s .. fn.fnamemodify(path, ":t")
			if fn.getbufvar(bufnr, '&modified') == 1 then
				s = s .. '+'
			else
				s = s .. ' '
			end
			s = s .. '%#TabLineFill#%T'
			i = i + 1
		end
		return s
	end
	local exec = vim.cmd
	exec('colorscheme zephyr')
	exec('hi TabLineSel gui=bold guibg='..COLORS.blue..' guifg='..COLORS.bg)
	exec('hi TabLine gui=NONE guibg='..COLORS.fg..' guifg='..COLORS.darkblue)
	vim.o.tabline = "%!v:lua.mytabline()"
end

function config.indent_guide()
	require('indent_guides').setup({
		even_colors = { fg = COLORS.yellow, bg = '#2a3834' };
		odd_colors = { fg = COLORS.yellow, bg = '#2a3834' };
		exclude_filetypes = { 'fern' }
	})
end

return config
