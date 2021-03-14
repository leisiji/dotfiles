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
			disable = { "c" }
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
	}
end

return config
