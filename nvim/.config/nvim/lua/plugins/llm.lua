local M = {}

function M.config()
  require("llm").setup({
    -- [[ siliconflow ]]
    url = "https://api.siliconflow.cn/v1/chat/completions",
    model = "deepseek-ai/DeepSeek-R1",
    api_type = "openai",
    max_tokens = 4096,
    temperature = 0.3,
    top_p = 0.7,

    prompt = "You are a helpful chinese assistant.",

    prefix = {
      user = { text = "😃 ", hl = "Title" },
      assistant = { text = "  ", hl = "Added" },
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

return M
