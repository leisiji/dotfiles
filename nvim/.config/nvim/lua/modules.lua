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
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-cmdline",
  --     "saadparwaiz1/cmp_luasnip",
  --     "L3MON4D3/LuaSnip",
  --     "rafamadriz/friendly-snippets",
  --     "onsails/lspkind.nvim",
  --   },
  --   config = function()
  --     require("plugins.cmp").config()
  --   end,
  -- },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { map_cr = true },
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = { "rafamadriz/friendly-snippets" },

    build = "cargo build --release",

    opts = {
      highlight = {
        use_nvim_cmp_as_default = true,
      },
      accept = { auto_brackets = { enabled = true } },
      nerd_font_variant = "normal",
      keymap = {
        show = "<C-q>",
        hide = "<C-e>",
        accept = "<Enter>",
        select_and_accept = {},
        select_prev = { "<S-Tab>", "<C-k>" },
        select_next = { "<Tab>", "<C-j>" },

        show_documentation = "<M-k>",
        hide_documentation = "<M-k>",
        scroll_documentation_up = "<M-k>",
        scroll_documentation_down = "<M-j>",

        snippet_forward = "<Tab>",
        snippet_backward = "<S-Tab>",
      },
      sources = {
        completion = {
          enabled_providers = { "lsp", "path", "snippets", "buffer" },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>e",
        function()
          require("plugins.conform").format()
        end,
        mode = "",
      },
    },
    config = function()
      require("plugins.conform").config()
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
    "MeanderingProgrammer/markdown.nvim",
    ft = "markdown",
    cmd = "RenderMarkdown",
    opts = {
      enabled = false,
    },
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
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
        },
        indent = {
          enable = true,
          delay = 800,
        },
        exclude_filetypes = {
          "neo-tree",
          "toggleterm",
          "grug-far",
        },
      })
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
        open = "tab",
      },
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
    config = function()
      require("plugins.neotree").config()
    end,
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
    "Mr-LLLLL/interestingwords.nvim",
    lazy = true,
    keys = { { "<leader>k" } },
    config = function()
      require("plugins.words").config()
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },

  {
    "akinsho/bufferline.nvim",
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
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline" },
    opts = {
      auto_close = true,
      keymaps = {
        down_and_jump = "<M-j>",
        up_and_jump = "<M-o>",
        peek_location = "p",
        hover_symbol = "<M-k>",
      },
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

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.noice").config()
    end,
  },

  {
    "MagicDuck/grug-far.nvim",
    lazy = true,
    keys = { { "<leader>d" } },
    cmd = "MyGrugFar",
    config = function()
      require("plugins.grug-far").config()
    end,
  },
}

if vim.fn.executable("fcitx5") == 1 then
  m[#m + 1] = { "h-hg/fcitx.nvim", event = "InsertEnter" }
end

require("lazy").setup(m)
