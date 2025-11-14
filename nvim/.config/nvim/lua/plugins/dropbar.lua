local M = {}

-- Cache for git branch information
local git_cache = {
  branch = "",
  git_dir = "",
}

-- Git branch source for dropbar
local function git_branch_source()
  local bar = require("dropbar.bar")
  local icon = ""

  return {
    get_symbols = function(buf, win, cursor)
      -- Check if we're in a git repository
      local buf_path = vim.api.nvim_buf_get_name(buf)
      local buf_dir = buf_path ~= "" and vim.fn.fnamemodify(buf_path, ":h") or vim.fn.getcwd()
      local current_git_dir = vim.fn.finddir(".git", buf_dir .. ";")
      if current_git_dir == "" then
        git_cache.branch = ""
        git_cache.git_dir = ""
        return {}
      end

      if git_cache.branch ~= "" and git_cache.git_dir == current_git_dir then
        return {
          bar.dropbar_symbol_t:new({
            name = git_cache.branch,
            icon = icon,
            icon_hl = "DropBarIconKindGit",
            name_hl = "DropBarGitClean",
            data = {
              branch = git_cache.branch,
              is_modified = false,
              git_dir = git_cache.git_dir,
            },
          }),
        }
      end

      local branch_cmd = "git -C " .. vim.fn.shellescape(buf_dir) .. " branch --show-current"
      local branch_output = vim.fn.systemlist(branch_cmd)
      local branch_name = branch_output[1] or ""

      if vim.v.shell_error ~= 0 or branch_name == "" then
        git_cache.branch = ""
        git_cache.git_dir = ""
        return {}
      end

      branch_name = " " .. branch_name:gsub("%s+", "")
      git_cache.branch = branch_name
      git_cache.git_dir = current_git_dir

      return {
        bar.dropbar_symbol_t:new({
          name = branch_name,
          icon = icon,
          icon_hl = "DropBarIconKindGit",
          name_hl = "DropBarGitClean",
          data = {
            branch = branch_name,
            is_modified = false,
            git_dir = current_git_dir,
          },
        }),
      }
    end,
  }
end

-- Vi mode source for dropbar
local function vi_mode_source()
  local bar = require("dropbar.bar")

  local mode_icons = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    c = "COMMAND",
    R = "REPLACE",
    s = "SELECT",
    S = "S-LINE",
    t = "TERMINAL",
    ["\22"] = "V-BLOCK", -- Ctrl-V
  }

  local mode_highlights = {
    n = "DropBarViNormal",
    i = "DropBarViInsert",
    v = "DropBarViVisual",
    V = "DropBarViVisual",
    c = "DropBarViCommand",
    R = "DropBarViReplace",
    s = "DropBarViSelect",
    S = "DropBarViSelect",
    t = "DropBarViTerminal",
    ["\22"] = "DropBarViVisual",
  }

  return {
    get_symbols = function(_, _, _)
      local mode = vim.fn.mode()
      local mode_name = mode_icons[mode] or mode:upper()
      local mode_hl = mode_highlights[mode] or "DropBarViNormal"

      return {
        bar.dropbar_symbol_t:new({
          name = mode_name,
          icon = "",
          icon_hl = mode_hl,
          name_hl = mode_hl,
          data = {
            mode = mode,
            mode_name = mode_name,
          },
        }),
      }
    end,
  }
end

-- Setup highlight groups for git integration
local function setup_git_highlights()
  vim.api.nvim_set_hl(0, "DropBarIconKindGit", { fg = "#ff6b6b", bg = "#3c3836", bold = true })
  vim.api.nvim_set_hl(0, "DropBarGitBranch", { fg = "#83a598", bg = "#3c3836" })
  vim.api.nvim_set_hl(0, "DropBarGitModified", { fg = "#fabd2f", bg = "#3c3836", bold = true })
  vim.api.nvim_set_hl(0, "DropBarGitClean", { fg = "#8ec07c", bg = "#3c3836" })
end

-- Setup highlight groups for vi mode integration
local function setup_vi_mode_highlights()
  vim.api.nvim_set_hl(0, "DropBarViNormal", { fg = "#000000", bg = "#89ca78", bold = true })
  vim.api.nvim_set_hl(0, "DropBarViInsert", { fg = "#000000", bg = "#61afef", bold = true })
  vim.api.nvim_set_hl(0, "DropBarViVisual", { fg = "#000000", bg = "#d55fde", bold = true })
  vim.api.nvim_set_hl(0, "DropBarViCommand", { fg = "#000000", bg = "#e5c07b", bold = true })
  vim.api.nvim_set_hl(0, "DropBarViReplace", { fg = "#000000", bg = "#ef596f", bold = true })
  vim.api.nvim_set_hl(0, "DropBarViSelect", { fg = "#000000", bg = "#2bbac5", bold = true })
  vim.api.nvim_set_hl(0, "DropBarViTerminal", { fg = "#000000", bg = "#d19a66", bold = true })
end

function M.config()
  local opts = {
    bar = {
      enable = function(buf, win)
        return vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" and not vim.wo[win].diff
      end,
      update_debounce = 500,
      update_events = {
        win = {
          "CursorHold",
          "WinEnter",
          "WinResized",
        },
        buf = {
          "CursorHold",
          "TextChanged",
          "TextChangedI",
        },
        global = {
          "DirChanged",
          "VimResized",
          "ModeChanged",
        },
      },
      -- Custom sources configuration
      sources = function(buf, win)
        local sources = require("dropbar.sources")

        return {
          vi_mode_source(), -- Add vi mode as first source
          git_branch_source(), -- Add git branch as second source
          sources.path,
          require("dropbar.utils").source.fallback({
            sources.lsp,
            sources.treesitter,
          }),
        }
      end,
    },
    menu = {
      preview = false,
      keymaps = {
        ["l"] = function()
          local menu = require("dropbar.utils.menu").get_current()
          if not menu then
            return
          end
          local cursor = vim.api.nvim_win_get_cursor(menu.win)
          local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
          if component then
            menu:click_on(component, nil, 1, "l")
          end
        end,
        ["q"] = function()
          vim.cmd("q")
        end,
      },
    },
  }
  require("dropbar").setup(opts)

  -- Setup custom highlight groups for git integration
  setup_git_highlights()

  -- Setup custom highlight groups for vi mode integration
  setup_vi_mode_highlights()

  vim.keymap.set("n", "<leader>i", function()
    local bar = require("dropbar.utils.bar")
    local b = bar.get_current()
    local f = vim.fn.expand("%:t")
    if b == nil then
      return
    end
    for i, component in ipairs(b.components) do
      if component.name == f then
        b:pick(i)
        return
      end
    end
  end, { noremap = true, silent = true })
end

return M
