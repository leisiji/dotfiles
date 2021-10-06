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

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
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
      ["<Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require('luasnip')
        if vim.fn.pumvisible() == 1 then
          feedkey("<C-n>", "n")
        elseif luasnip.expand_or_jumpable() == 1 then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        local luasnip = require('luasnip')
        if vim.fn.pumvisible() == 1 then
          feedkey("<C-p>", "n")
        elseif luasnip.jumpable(-1) == 1 then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = {
      {
        name = 'buffer',
        opts = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end
        }
      },
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