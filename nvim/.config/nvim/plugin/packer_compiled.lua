-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/ye/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/ye/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/ye/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/ye/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/ye/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FTerm.nvim"] = {
    commands = { "FTermToggle" },
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\18plugins.fterm\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/FTerm.nvim"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen" },
    config = { "\27LJ\2\n¶\2\0\0\4\0\t\0\r6\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0005\2\a\0005\3\6\0=\3\b\2B\0\2\1K\0\1\0\15file_panel\1\0\0\1\0\1\14use_icons\1\nsetup\rdiffview\frequire≥\1    hi DiffAdd    guibg=#26332c guifg=NONE\n    hi DiffChange guibg=#273842 guifg=NONE\n    hi DiffDelete guibg=#572E33 guifg=NONE\n    hi DiffText   guibg=#314753 guifg=NONE\n  \bcmd\bvim\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/diffview.nvim"
  },
  ["fcitx.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/fcitx.vim"
  },
  ["fern.vim"] = {
    commands = { "Fern" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/fern.vim"
  },
  ["formatter.nvim"] = {
    commands = { "Format" },
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22plugins.formatter\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/formatter.nvim"
  },
  ["friendly-snippets"] = {
    load_after = {
      ["nvim-autopairs"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/friendly-snippets"
  },
  fzf_utils = {
    after = { "nvim-fzf" },
    commands = { "FzfCommand" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/fzf_utils"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n{\0\0\5\0\6\0\0176\0\0\0006\1\1\0009\1\2\0019\1\3\1B\1\1\0028\0\1\0\n\0\0\0X\1\bÄ6\1\1\0009\1\4\1'\3\5\0:\4\1\0&\3\4\3B\1\2\1:\1\2\0L\1\2\0K\0\1\0\27hi GalaxyViMode guibg=\bcmd\tmode\afn\bvim\rVI_MODES/\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\22current_func_name\6b\bvim)\0\0\3\0\4\0\0056\0\0\0009\0\1\0009\0\2\0'\2\3\0D\0\2\0\6$\tline\afn\bvimà\3\1\0\a\0\26\0+6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0015\3\v\0005\4\5\0003\5\4\0=\5\6\0045\5\t\0006\6\a\0009\6\b\6>\6\1\0056\6\a\0009\6\b\6>\6\2\5=\5\n\4=\4\f\3>\3\1\0029\2\3\0015\3\15\0005\4\14\0004\5\3\0003\6\r\0>\6\1\5=\5\6\4=\4\16\3>\3\2\0029\2\17\0015\3\19\0005\4\18\0=\4\20\3>\3\1\0029\2\17\0015\3\23\0005\4\22\0003\5\21\0=\5\6\4=\4\24\3>\3\2\0029\2\25\0B\2\1\1K\0\1\0\20load_galaxyline\fMaxLine\1\0\0\1\0\1\14separator\b | \0\15BufferType\1\0\0\1\0\2\14separator\b | \rprovider\17FileTypeName\nright\tfunc\1\0\0\1\0\1\ticon\n  Œª \0\vViMode\1\0\0\14highlight\1\4\0\0\0\0\tbold\abg\vCOLORS\rprovider\1\0\0\0\tleft\fsection\15galaxyline\frequire\0" },
    loaded = true,
    path = "/home/ye/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n¥\4\0\0\5\0\20\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\2B\0\2\1K\0\1\0\fkeymaps\1\0\5\24n <leader><leader>n/<cmd>lua require\"gitsigns\".next_hunk()<CR>\24n <leader><leader>b0<cmd>lua require\"gitsigns\".blame_line()<CR>\fnoremap\2\vbuffer\2\24n <leader><leader>N/<cmd>lua require\"gitsigns\".prev_hunk()<CR>\16watch_index\1\0\1\rinterval\3à'\nsigns\1\0\0\17changedelete\1\0\2\ahl\20GitGutterChange\ttext\6~\14topdelete\1\0\2\ahl\20GitGutterDelete\ttext\b‚Äæ\vdelete\1\0\2\ahl\20GitGutterDelete\ttext\6_\vchange\1\0\2\ahl\20GitGutterChange\ttext\6~\badd\1\0\0\1\0\2\ahl\17GitGutterAdd\ttext\6+\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    commands = { "Glow" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/glow.nvim"
  },
  ["indent-guides.nvim"] = {
    config = { "\27LJ\2\nê\1\0\0\4\0\n\0\r5\0\2\0006\1\0\0009\1\1\1=\1\3\0006\1\4\0'\3\5\0B\1\2\0029\1\6\0015\3\a\0=\0\b\3=\0\t\3B\1\2\1K\0\1\0\15odd_colors\16even_colors\1\0\0\nsetup\18indent_guides\frequire\afg\1\0\1\abg\f#2a3834\vyellow\vCOLORS\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/indent-guides.nvim"
  },
  ["inline_edit.vim"] = {
    commands = { "InlineEdit" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/inline_edit.vim"
  },
  ["interestingwords.nvim"] = {
    commands = { "Interestingwords" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/interestingwords.nvim"
  },
  ["lspsaga.nvim"] = {
    commands = { "Lspsaga" },
    config = { "\27LJ\2\n™\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\23finder_action_keys\tquit\1\3\0\0\6q\n<ESC>\1\0\3\vvsplit\6v\nsplit\6s\topen\t<cr>\1\0\1\22max_preview_lines\3\25\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20plugins.lua_dev\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/lua-dev.nvim"
  },
  ["nvim-autopairs"] = {
    after = { "vim-vsnip-integ", "vim-vsnip", "friendly-snippets" },
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\18plugins.pairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    after_files = { "/home/ye/.local/share/nvim/site/pack/packer/opt/nvim-compe/after/plugin/compe.vim" },
    config = { "\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\18plugins.compe\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/nvim-compe"
  },
  ["nvim-fzf"] = {
    load_after = {
      fzf_utils = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/nvim-fzf"
  },
  ["nvim-jdtls"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\17plugins.java\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15lsp_config\22plugins.lspconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÖ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14highlight\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/ye/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/ye/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim"
  },
  ["vim-easy-align"] = {
    commands = { "EasyAlign" },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/vim-easy-align"
  },
  ["vim-surround"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/vim-surround"
  },
  ["vim-vsnip"] = {
    load_after = {
      ["nvim-autopairs"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    after_files = { "/home/ye/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ/after/plugin/vsnip_integ.vim" },
    load_after = {
      ["nvim-autopairs"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/ye/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  ["zephyr-nvim"] = {
    config = { "\27LJ\2\n’\1\0\0\a\0\n\0\0246\0\0\0009\0\1\0\18\1\0\0'\3\2\0B\1\2\1\18\1\0\0'\3\3\0006\4\4\0009\4\5\4'\5\6\0006\6\4\0009\6\a\6&\3\6\3B\1\2\1\18\1\0\0'\3\b\0006\4\4\0009\4\t\4'\5\6\0006\6\4\0009\6\a\6&\3\6\3B\1\2\1K\0\1\0\afg\31hi TabLine gui=NONE guibg=\abg\f guifg=\tblue\vCOLORS\"hi TabLineSel gui=bold guibg=\23colorscheme zephyr\bcmd\bvim\0" },
    loaded = true,
    path = "/home/ye/.local/share/nvim/site/pack/packer/start/zephyr-nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: inline_edit.vim
time([[Setup for inline_edit.vim]], true)
try_loadstring("\27LJ\2\nn\0\0\2\0\5\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\26inline_edit_autowrite\ftabedit#inline_edit_new_buffer_command\6g\bvim\0", "setup", "inline_edit.vim")
time([[Setup for inline_edit.vim]], false)
-- Setup for: fern.vim
time([[Setup for fern.vim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\17plugins.fern\frequire\0", "setup", "fern.vim")
time([[Setup for fern.vim]], false)
-- Config for: zephyr-nvim
time([[Config for zephyr-nvim]], true)
try_loadstring("\27LJ\2\n’\1\0\0\a\0\n\0\0246\0\0\0009\0\1\0\18\1\0\0'\3\2\0B\1\2\1\18\1\0\0'\3\3\0006\4\4\0009\4\5\4'\5\6\0006\6\4\0009\6\a\6&\3\6\3B\1\2\1\18\1\0\0'\3\b\0006\4\4\0009\4\t\4'\5\6\0006\6\4\0009\6\a\6&\3\6\3B\1\2\1K\0\1\0\afg\31hi TabLine gui=NONE guibg=\abg\f guifg=\tblue\vCOLORS\"hi TabLineSel gui=bold guibg=\23colorscheme zephyr\bcmd\bvim\0", "config", "zephyr-nvim")
time([[Config for zephyr-nvim]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n{\0\0\5\0\6\0\0176\0\0\0006\1\1\0009\1\2\0019\1\3\1B\1\1\0028\0\1\0\n\0\0\0X\1\bÄ6\1\1\0009\1\4\1'\3\5\0:\4\1\0&\3\4\3B\1\2\1:\1\2\0L\1\2\0K\0\1\0\27hi GalaxyViMode guibg=\bcmd\tmode\afn\bvim\rVI_MODES/\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\22current_func_name\6b\bvim)\0\0\3\0\4\0\0056\0\0\0009\0\1\0009\0\2\0'\2\3\0D\0\2\0\6$\tline\afn\bvimà\3\1\0\a\0\26\0+6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0015\3\v\0005\4\5\0003\5\4\0=\5\6\0045\5\t\0006\6\a\0009\6\b\6>\6\1\0056\6\a\0009\6\b\6>\6\2\5=\5\n\4=\4\f\3>\3\1\0029\2\3\0015\3\15\0005\4\14\0004\5\3\0003\6\r\0>\6\1\5=\5\6\4=\4\16\3>\3\2\0029\2\17\0015\3\19\0005\4\18\0=\4\20\3>\3\1\0029\2\17\0015\3\23\0005\4\22\0003\5\21\0=\5\6\4=\4\24\3>\3\2\0029\2\25\0B\2\1\1K\0\1\0\20load_galaxyline\fMaxLine\1\0\0\1\0\1\14separator\b | \0\15BufferType\1\0\0\1\0\2\14separator\b | \rprovider\17FileTypeName\nright\tfunc\1\0\0\1\0\1\ticon\n  Œª \0\vViMode\1\0\0\14highlight\1\4\0\0\0\0\tbold\abg\vCOLORS\rprovider\1\0\0\0\tleft\fsection\15galaxyline\frequire\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
if vim.fn.exists(":Fern") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Fern lua require("packer.load")({'fern.vim'}, { cmd = "Fern", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":FTermToggle") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file FTermToggle lua require("packer.load")({'FTerm.nvim'}, { cmd = "FTermToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":InlineEdit") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file InlineEdit lua require("packer.load")({'inline_edit.vim'}, { cmd = "InlineEdit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Interestingwords") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Interestingwords lua require("packer.load")({'interestingwords.nvim'}, { cmd = "Interestingwords", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":EasyAlign") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file EasyAlign lua require("packer.load")({'vim-easy-align'}, { cmd = "EasyAlign", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":SymbolsOutline") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Glow") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Glow lua require("packer.load")({'glow.nvim'}, { cmd = "Glow", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Format") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Format lua require("packer.load")({'formatter.nvim'}, { cmd = "Format", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":FzfCommand") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file FzfCommand lua require("packer.load")({'fzf_utils'}, { cmd = "FzfCommand", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":DiffviewOpen") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
if vim.fn.exists(":Lspsaga") ~= 2 then
vim.cmd [[command! -nargs=* -range -bang -complete=file Lspsaga lua require("packer.load")({'lspsaga.nvim'}, { cmd = "Lspsaga", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
end
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType help ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "help" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'lua-dev.nvim', 'nvim-colorizer.lua'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'nvim-jdtls'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "css" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter', 'gitsigns.nvim', 'indent-guides.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'vim-surround', 'nvim-autopairs', 'nvim-compe', 'fcitx.vim'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-lspconfig'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
