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

function M.config()
  local cmp = require("cmp")
  local snip = require("luasnip")
  local lspkind = require('lspkind')

  local sel_next = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif snip.expand_or_jumpable() == 1 then
      snip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s", "c" })

  local sel_prev = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif snip.jumpable(-1) == 1 then
      snip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s", "c" })

  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = {
      ["<C-e>"] = cmp.mapping.scroll_docs(-4),
      ["<C-y>"] = cmp.mapping.scroll_docs(4),
      ["<C-c>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = sel_next,
      ["<C-j>"] = sel_next,
      ["<C-k>"] = sel_prev,
    },
    snippet = {
      expand = function(args)
        snip.lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
      {
        name = "buffer",
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end,
        },
      },
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        show_labelDetails = true,
        before = function(entry, vim_item)
          return vim_item
        end,
      }),
    },
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  require("luasnip.loaders.from_vscode").lazy_load({
    paths = {
      fn.stdpath("data") .. "/lazy/friendly-snippets",
      fn.stdpath("config") .. "/snippets",
    },
  })

  require("nvim-autopairs").setup()
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return M
