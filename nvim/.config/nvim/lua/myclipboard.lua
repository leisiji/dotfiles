vim.g.clipboard = {
  name = "OSC 52",
  copy = { ["*"] = { "tmux", "load-buffer", "-" }, ["+"] = require("vim.clipboard.osc52").copy },
  paste = { ["*"] = { "tmux", "save-buffer", "-" }, ["+"] = require("vim.clipboard.osc52").paste },
}
