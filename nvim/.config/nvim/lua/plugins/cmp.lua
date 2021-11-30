local M = {}
local fn = vim.fn
local a = vim.api

local has_words_before = function()
  if a.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(a.nvim_win_get_cursor(0))
  return col ~= 0 and a.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function config_snip()
  require('nvim-autopairs').setup()
  require('luasnip.loaders.from_vscode').load({
    paths = {
      fn.stdpath('data')..'/site/pack/packer/opt/friendly-snippets/',
      fn.stdpath('config').."/snippets"
    }
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
end

function M.config()
  local cmp = require('cmp')

  local sel_next = cmp.mapping(function(fallback)
    local luasnip = require('luasnip')
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() == 1 then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { 'i', 's', 'c' })

  local sel_prev = cmp.mapping(function(fallback)
    local luasnip = require('luasnip')
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) == 1 then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's', 'c' })

  cmp.setup {
    mapping = {
      ['<C-e>'] = cmp.mapping.scroll_docs(-4),
      ['<C-y>'] = cmp.mapping.scroll_docs(4),
      ['<C-c>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = sel_next,
      ['<C-j>'] = sel_next,
      ["<C-k>"] = sel_prev,
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer', option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end }
      },
    })
  }

  cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
  })

  vim.schedule(function ()
    config_snip()
  end)
end

function M.config_pairs()
end

return M
