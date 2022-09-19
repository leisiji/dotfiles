local packer = require("packer")
local use = packer.use

local function colorscheme()
  if vim.g.vscode then
    return
  end

  local onedarkpro = require("onedarkpro")
  onedarkpro.setup({
    colors = {
      onedark = {
        bg = "#1e1e1e",
      },
    },
    highlights = {
      TabLineSel = { fg = "${bg}", bg = "${blue}" },
    },
    options = {
      cursorline = true,
    },
  })
  onedarkpro.load()
end

-- treesitter
local function treesitter()
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = { enable = true },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
        },
      },
    },
  })
end

-- gitsigns
local function gitsigns()
  require("gitsigns").setup({
    watch_gitdir = {
      interval = 5000,
      follow_files = true,
    },
    keymaps = {
      noremap = true,
      buffer = true,
      ["n <leader><leader>n"] = '<cmd>lua require"gitsigns".next_hunk()<CR>',
      ["n <leader><leader>N"] = '<cmd>lua require"gitsigns".prev_hunk()<CR>',
      ["n <leader><leader>b"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    },
  })
end

local function filetype()
  require("filetype").setup({
    overrides = {
      extensions = {
        rc = "rc",
        hal = "hal",
      },
    },
  })
end

local function indent()
  require("indent-o-matic").setup({
    max_lines = 2048,
    filetype_rust = { standard_widths = { 4 } },
    filetype_python = { standard_widths = { 4 } },
    filetype_markdown = { standard_widths = { 4 } },
  })
end

packer.startup(function()
  use({ "wbthomason/packer.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "nathom/filetype.nvim", config = filetype })

  use({ "leisiji/fzf_utils", opt = true, cmd = "FzfCommand", requires = { "vijaymarupudi/nvim-fzf" } })

  -- colorscheme and statusline
  use({ "olimorris/onedarkpro.nvim", config = colorscheme })
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter-textobjects",
    run = ":TSUpdate",
    config = treesitter,
  })

  -- lsp
  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    requires = "theHamsta/nvim-semantic-tokens",
    opt = true,
    config = function()
      require("plugins.lspconfig").lsp_config()
    end,
  })
  use({
    "theHamsta/nvim-semantic-tokens",
    event = "BufReadPost",
    opt = true,
    config = function()
      require("nvim-semantic-tokens").setup({
        preset = "default",
        highlighters = { require("nvim-semantic-tokens.table-highlighter") },
      })
    end,
  })
  use({
    "mfussenegger/nvim-jdtls",
    opt = true,
    requires = { "leisiji/nvim-android" },
    ft = { "java" },
    config = function()
      require("plugins.java").config()
    end,
  })
  use({
    "simrat39/symbols-outline.nvim",
    opt = true,
    cmd = "SymbolsOutline",
    config = function()
      require("plugins.symbols_outline").config()
    end,
  })
  use({
    "rmagatti/goto-preview",
    opt = true,
    cmd = "GotoPreview",
    config = function()
      require("plugins.goto_preview").config()
    end,
  })
  use({
    "folke/lua-dev.nvim",
    opt = true,
    ft = { "lua" },
    config = function()
      require("plugins.lua_dev").config()
    end,
  })

  use({
    "ldelossa/litee-calltree.nvim",
    opt = true,
    requires = { "ldelossa/litee.nvim" },
    cmd = "CallTreeI",
    wants = "litee.nvim",
    config = function()
      require("plugins.calltree").config()
    end,
  })

  -- Lua
  use({
    "kylechui/nvim-surround",
    event = "BufReadPre",
    opt = true,
    config = function()
      require("plugins.surround").config()
    end,
  })

  use({
    "hrsh7th/nvim-cmp",
    opt = true,
    event = "InsertEnter",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "windwp/nvim-autopairs",
    },
    config = function()
      require("plugins.cmp").config()
    end,
  })

  -- code format
  use({
    "mhartington/formatter.nvim",
    opt = true,
    cmd = "Format",
    config = function()
      require("plugins.formatter").config()
    end,
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim", opt = true, event = "BufRead", config = gitsigns })
  use({
    "sindrets/diffview.nvim",
    opt = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require("plugins.diffview").config()
    end,
  })

  use({ "leisiji/simple_indent", opt = true, event = "BufRead" })
  use({ "leisiji/indent-o-matic", config = indent })
  use({
    "AckslD/nvim-FeMaco.lua",
    opt = true,
    config = function()
      require("femaco").setup()
    end,
    cmd = "FeMaco",
  })
  use({
    "numToStr/FTerm.nvim",
    opt = true,
    cmd = "FTermToggle",
    config = function()
      require("plugins.fterm").config()
    end,
  })
  use({ "leisiji/interestingwords.nvim", opt = true, cmd = "Interestingwords" })
  use({ "npxbr/glow.nvim", opt = true, cmd = "Glow" })
  use({ "junegunn/vim-easy-align", opt = true, cmd = "EasyAlign" })
  use({
    "norcalli/nvim-colorizer.lua",
    opt = true,
    ft = { "html", "css", "help", "lua", "vim" },
    config = function()
      require("colorizer").setup()
    end,
  })

  use({
    "kyazdani42/nvim-tree.lua",
    opt = true,
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = function()
      require("plugins.nvim_tree").setup()
    end,
  })
  use({
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({})
    end,
  })

  if vim.fn.executable("fcitx5") == 1 then
    use({ "h-hg/fcitx.nvim", opt = true, event = "InsertEnter" })
  end

  use({
    "mfussenegger/nvim-lint",
    opt = true,
    event = "BufReadPost",
    config = function()
      require("plugins.lint").config()
    end,
  })
end)
