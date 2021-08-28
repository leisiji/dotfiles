local M = {}
local fn = vim.fn
local a = vim.api

local t = function (str)
  return a.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = fn.col('.') - 1
  if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

local function config_snip()
  --vim.g.vsnip_snippet_dir = string.format("%s/snippets", fn.stdpath('config'))
  require('nvim-autopairs').setup()
  require('luasnip.loaders.from_vscode').load({
    paths = {
      fn.stdpath('data')..'/site/pack/packer/opt/friendly-snippets/',
      fn.stdpath('config').."/snippets"
    }
  })
  require("nvim-autopairs.completion.cmp").setup(
    { map_cr = true, map_complete = true, auto_select = true }
  )
end

function M.config()
  local cmp = require('cmp')
  cmp.setup {
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-e>'] = cmp.mapping.scroll_docs(-4),
      ['<C-y>'] = cmp.mapping.scroll_docs(4),
      ['<C-l>'] = cmp.mapping.complete(),
      ['<C-c>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      ['<Tab>'] = function(fallback)
          if fn.pumvisible() == 1 then
            fn.feedkeys(t('<C-n>'), 'n')
          elseif check_back_space() then
            fn.feedkeys(t('<Tab>'), 'n')
          elseif vim.fn['vsnip#available']() == 1 then
            fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
          else
            fallback()
          end
      end,
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = {
      { name = 'buffer' },
      { name = 'nvim_lsp' },
      { name = 'path' },
      { name = 'luasnip' },
    },
  }

  vim.schedule(function ()
    config_snip()
  end)
end

function M.config_pairs()
end

return M
