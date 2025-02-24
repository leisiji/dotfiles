local M = {}

local llm_url = vim.env.LLM_URL or "https://api.siliconflow.cn/v1/chat/completions"
local llm_model = vim.env.LLM_MODEL or "Qwen/Qwen2.5-7B-Instruct"
local llm_api = vim.env.LLM_API_TYPE or "openai"

function M.config()
  local tools = require("llm.tools")

  require("llm").setup({
    -- [[ siliconflow ]]
    url = llm_url,
    model = llm_model,
    api_type = llm_api,
    max_tokens = 4096,
    temperature = 0.3,
    top_p = 0.7,

    prompt = "You are a helpful chinese assistant.",

    prefix = {
      user = { text = "😃 ", hl = "Title" },
      assistant = { text = "  ", hl = "Added" },
    },

    app_handler = {
      TestCode = {
        handler = tools.side_by_side_handler,
        prompt = [[ Write some test cases for the following code, only return the test cases.
            Give the code content directly, do not use code blocks or other tags to wrap it. ]],
        opts = {
          right = {
            title = " Test Cases ",
          },
        },
      },
      CodeExplain = {
        handler = tools.flexi_handler,
        prompt = "Explain the following code, please only return the explanation, and answer in Chinese",
        opts = {
          url = llm_url,
          model = llm_model,
          api_type = llm_api,
          enter_flexible_window = true,
        },
      },
      Translate = {
        handler = tools.qa_handler,
        opts = {
          url = llm_url,
          model = llm_model,
          api_type = llm_api,

          component_width = "60%",
          component_height = "50%",
          query = {
            title = " 󰊿 Trans ",
            hl = { link = "Define" },
          },
          input_box_opts = {
            size = "15%",
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          },
          preview_box_opts = {
            size = "85%",
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          },
        },
      },
      CommitMsg = {
        handler = tools.flexi_handler,
        prompt = function()
          -- Source: https://andrewian.dev/blog/ai-git-commits
          return string.format(
            [[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

1. First line: conventional commit format (type: concise description) (remember to use semantic types like feat, fix, docs, style, refactor, perf, test, chore, etc.)
2. Optional bullet points if more context helps:
   - Keep the second line blank
   - Keep them short and direct
   - Focus on what changed
   - Always be terse
   - Don't overly explain
   - Drop any fluffy or formal language

Return ONLY the commit message - no introduction, no explanation, no quotes around it.

Examples:
feat: add user auth system

- Add JWT tokens for API auth
- Handle token refresh for long sessions

fix: resolve memory leak in worker pool

- Clean up idle connections
- Add timeout for stale workers

Simple change example:
fix: typo in README.md

Very important: Do not respond with any of the examples. Your message must be based off the diff that is about to be provided, with a little bit of styling informed by the recent commits you're about to see.

Based on this format, generate appropriate commit messages. Respond with message only. DO NOT format the message in Markdown code blocks, DO NOT use backticks:

```diff
%s
```
]],
            vim.fn.system("git diff --no-ext-diff --staged")
          )
        end,
        opts = {
          url = llm_url,
          model = llm_model,
          api_type = llm_api,
          enter_flexible_window = true,
          apply_visual_selection = false,
        },
      },
      Completion = {
        handler = tools.completion_handler,
        opts = {
          -------------------------------------------------
          ---                   ollama
          -------------------------------------------------
          url = llm_url,
          model = llm_model,
          api_type = llm_api,

          n_completions = 3,
          context_window = 512,
          max_tokens = 256,
          filetypes = { sh = false },
          default_filetype_enabled = true,
          auto_trigger = true,
          only_trigger_by_keywords = true,
          style = "blink.cmp",
          timeout = 10,
          throttle = 1000,
          debounce = 400,

          keymap = {
            virtual_text = {
              accept = {
                mode = "i",
                keys = "<A-a>",
              },
              next = {
                mode = "i",
                keys = "<A-n>",
              },
              prev = {
                mode = "i",
                keys = "<A-p>",
              },
              toggle = {
                mode = "n",
                keys = "<leader>cp",
              },
            },
          },
        },
      },
    },

    -- history_path = "/tmp/llm-history",
    save_session = true,
    max_history = 15,
    max_history_name_length = 20,
    keys = {
      -- The keyboard mapping for the input window.
      ["Input:Submit"] = { mode = "n", key = "<cr>" },
      ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },
      ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },

      -- only works when "save_session = true"
      ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
      ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },

      -- The keyboard mapping for the output window in "split" style.
      ["Output:Ask"] = { mode = "n", key = "i" },
      ["Output:Cancel"] = { mode = "n", key = "<C-c>" },
      ["Output:Resend"] = { mode = "n", key = "<C-r>" },

      -- The keyboard mapping for the output and input windows in "float" style.
      ["Session:Toggle"] = { mode = "n", key = "<leader>ac" },
      ["Session:Close"] = { mode = "n", key = { "<esc>", "Q" } },
    },
  })
end

M.llm_api = llm_api

return M
