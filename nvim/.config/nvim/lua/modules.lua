local m = {
  { "nvim-lua/plenary.nvim" },

  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.onedark").config()
    end,
  },

  {
    "leisiji/fzf_utils",
    cmd = "FzfCommand",
    dependencies = { "vijaymarupudi/nvim-fzf" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("plugins.treesitter").config()
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    config = function()
      require("plugins.lspconfig").lsp_config()
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      require("plugins.java").config()
    end,
  },
  {
    "rmagatti/goto-preview",
    cmd = "GotoPreview",
    config = function()
      require("plugins.goto_preview").config()
    end,
  },
  {
    "folke/neodev.nvim",
    ft = "lua",
    config = function()
      require("plugins.neodev").config()
    end,
  },

  -- completion
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("plugins.surround").config()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "windwp/nvim-autopairs",
    },
    config = function()
      require("plugins.cmp").config()
    end,
  },

  {
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = function()
      require("plugins.formatter").config()
    end,
  },

  -- markdown
  {
    "AckslD/nvim-FeMaco.lua",
    config = function()
      require("plugins.femaco").config()
    end,
    cmd = "FeMaco",
  },
  {
    "npxbr/glow.nvim",
    config = function()
      require("glow").setup()
    end,
    cmd = "Glow",
  },
  {
    "junegunn/vim-easy-align",
    cmd = "EasyAlign",
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.gitsigns").config()
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require("plugins.diffview").config()
    end,
  },

  -- indent
  {
    "nvimdev/indentmini.nvim",
    event = "BufReadPre",
    dependencies = "NMAC427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
      require('indentmini').setup({
        char = "│",
      })
      vim.cmd.highlight("default link IndentLine Comment")
    end,
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("plugins.toggleterm").config()
    end,
    cmd = { "ToggleTerm", "TermExec" },
  },

  {
    "willothy/flatten.nvim",
    opts = {
      window = {
        open = "tab"
      }
    },
    lazy = false,
    priority = 1001,
  },

  {
    "norcalli/nvim-colorizer.lua",
    ft = { "html", "css", "help", "lua", "vim" },
    config = function()
      require("colorizer").setup()
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    lazy = true,
    cmd = "Neotree",
    config = function ()
      require("plugins.neotree").config()
    end
  },

  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "terminal" },
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = "BufReadPost",
    config = function()
      require("plugins.lint").config()
    end,
  },

  {
    "leisiji/interestingwords.nvim",
    cmd = "Interestingwords",
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    config = function()
      require("plugins.bufferline").config()
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  {
    "Bekaboo/dropbar.nvim",
    event = "BufReadPost",
    config = function()
      require("plugins.dropbar").config()
    end,
  },

  {
    "stevearc/aerial.nvim",
    lazy = true,
    cmd = "AerialOpen",
    opts = {
      keymaps = {
        ["<CR>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-j>"] = false,
        ["<C-k>"] = false,
      },
      close_on_select = true,
    },
  },
  {
    "ldelossa/litee-calltree.nvim",
    lazy = true,
    cmd = "CallTreeI",
    dependencies = "ldelossa/litee.nvim",
    config = function()
      require("plugins.calltree").config()
    end,
  },
}

if vim.fn.executable("fcitx5") == 1 then
  m[#m + 1] = { "h-hg/fcitx.nvim", event = "InsertEnter" }
end

require("lazy").setup(m)
