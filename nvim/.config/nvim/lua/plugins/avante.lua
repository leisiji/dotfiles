local M = {}

function M.config()
  local config = {
    -- add any opts here
    -- for example
    provider = "siliconflow",
    vendors = {
      ollama = {
        __inherited_from = "openai",
        api_key_name = "",
        endpoint = vim.env.LLM_URL,
        model = vim.env.LLM_MODEL,
        disable_tools = true,
      },
      siliconflow = {
        __inherited_from = "openai",
        endpoint = "https://api.siliconflow.cn/v1",
        model = "deepseek-ai/DeepSeek-R1",
        api_key_name = "SILICONFLOW_API_KEY",
        disable_tools = true,
      },
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-coder",
      },
    },
  }
  if vim.env.LLM_URL then
    config.provider = "ollama"
  end
  require("avante").setup(config)
end

return M
