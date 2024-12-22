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

    opts = require("plugins.blink").config,
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
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    opts = {
      initial_state = false,
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
    opts = {
      filetype_exclude = {
        "markdown",
      },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      chunk = {
        enable = true,
      },
      indent = {
        enable = true,
        delay = 800,
      },
      exclude_filetypes = {
        "minifiles",
        "toggleterm",
        "grug-far",
      },
    },
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
    "catgoose/nvim-colorizer.lua",
    lazy = true,
    ft = { "html", "css", "help", "lua", "vim" },
    opts = {},
  },

  {
    "echasnovski/mini.files",
    lazy = true,
    config = function()
      require("plugins.mini").config()
    end,
    keys = {
      {
        "<leader>tj",
        function()
          require("plugins.conform").format()
          MiniFiles.open(vim.api.nvim_buf_get_name(0))
        end,
        mode = "n",
      },
      {
        "<leader>tr",
        function()
          MiniFiles.open()
        end,
        mode = "n",
      },
    },
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
