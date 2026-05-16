function nh --description 'Open recent nvim files via fzf'
    nvim --noplugin --headless \
        -c "lua for _, f in ipairs(vim.v.oldfiles) do if vim.fn.filereadable(f) == 1 then io.write(f .. '\n') end end" \
        -c "qa" | \
        fzf | xargs -r nvim
end
