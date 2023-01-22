local copy, paste
if vim.env.WAYLAND_DISPLAY ~= nil then
  copy = { "wl-copy", "--foreground", "--type", "text/plain" }
  paste = { "wl-paste", "--no-newline" }
else
  copy = { "xclip", "-quiet", "-i", "-selection", "clipboard" }
  paste = { "xclip", "-o", "-selection", "clipboard" }
end
vim.g.clipboard = {
  copy = { ["*"] = { "tmux", "load-buffer", "-" }, ["+"] = copy },
  paste = { ["*"] = { "tmux", "save-buffer", "-" }, ["+"] = paste },
}
