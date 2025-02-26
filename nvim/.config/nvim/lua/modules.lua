local m = {
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },

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
    keys = {
      { "<leader><leader>p", "<cmd>GotoPreview<cr>" },
    },
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
      preview = {
        enable = false,
      },
    },
    keys = {
      { "<leader><leader>m", "<cmd>Markview toggle<cr>" },
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
    opts = {
      options = {
        mode = "tabs",
        numbers = function(opts)
          return string.format("%s", opts.ordinal)
        end,
      },
    },
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
      outline_window = {
        auto_close = true,
      },
      keymaps = {
        down_and_jump = "<M-j>",
        up_and_jump = "<M-o>",
        peek_location = "p",
        hover_symbol = "<M-k>",
      },
    },
    keys = {
      { "<leader>v", "Outline" },
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

  {
    "dnlhc/glance.nvim",
    lazy = true,
    cmd = "Glance",
    config = function()
      require("plugins.glance").config()
    end,
    keys = {
      { "<M-r>", "<cmd>Glance references<cr>" },
    },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    config = function()
      require("plugins.avante").config()
    end,
    build = "make BUILD_FROM_SOURCE=true",
    dependencies = {
      "stevearc/dressing.nvim",
    },
    keys = {
      { "<C-c>", "<cmd>AvanteToggle<cr>" },
    },
  },
}

if vim.fn.executable("fcitx5") == 1 then
  m[#m + 1] = { "h-hg/fcitx.nvim", event = "InsertEnter" }
end

if vim.fn.executable("magick") == 1 then
  m[#m + 1] = {
    "3rd/image.nvim",
    ft = "markdown",
    lazy = true,
    opts = {
      tmux_show_only_in_active_window = true,
      window_overlap_clear_enabled = true,
      integrations = {
        markdown = {
          only_render_image_at_cursor = true,
          clear_in_insert_mode = true,
          floating_windows = true,
        },
      },
    },
  }
end

require("lazy").setup(m)
