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
		-- one of "all", "maintained" , or a list of languages
		ensure_installed = "maintained",
		highlight = {
			enable = true,
		}
	}
end

-- gitsigns
function config.gitsigns()
	require('gitsigns').setup {
		signs = {
			add = {hl = 'DiffAdd', text = '+'},
			change = {hl = 'DiffChange', text = '~'},
			delete = { hl = 'DiffDelete', text = '_'},
			topdelete = { hl = 'DiffDelete', text = '‾'},
			changedelete = { hl = 'DiffChange', text = '~' }
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

function config.nvim_tree()
	local tree_cb = require'nvim-tree.config'.nvim_tree_callback
	vim.g.nvim_tree_bindings = {
		["v"]     = tree_cb("vsplit"),
		["s"]     = tree_cb("split"),
		["t"]     = tree_cb("tabnew"),
		["l"]     = tree_cb("edit"),
		["h"]     = tree_cb("close_node"),
		["<Tab>"] = tree_cb("preview"),
		["."]     = tree_cb("toggle_dotfiles"),
		["R"]     = tree_cb("refresh"),
		["a"]     = tree_cb("create"), -- Adding a dir requires an ending /
		["D"]     = tree_cb("remove"),
		["r"]     = tree_cb("rename"),
		["x"]     = tree_cb("cut"),
		["c"]     = tree_cb("copy"),
		["p"]     = tree_cb("paste"),
		["q"]     = tree_cb("close"),
		["<BS>"]  = tree_cb("dir_up"),
		["<CR>"]  = tree_cb("cd"),
	}
end

function config.colorscheme()
	function _G.mytabline()
		local pagenum = vim.fn.tabpagenr('$')
		local s = ''
		local i = 1
		while i <= pagenum  do
			if i == vim.fn.tabpagenr() then
				s = s..'%#TabLineSel#'
			else
				s = s..'%#TabLine#'
			end
			s = s .. tostring(i)
			local path = vim.fn.bufname(vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)])
			s = s .. ' ' .. vim.fn.fnamemodify(path, ":t")
			s = s .. ' %#TabLineFill#%T'
			i = i + 1
		end
		return s
	end
	vim.cmd('colorscheme zephyr')
	vim.cmd('hi TabLineSel guibg='..COLORS.blue..' guifg='..COLORS.bg)
	vim.cmd('hi TabLine guibg='..COLORS.fg..' guifg='..COLORS.darkblue)
	vim.o.tabline = "%!v:lua.mytabline()"
end

return config
