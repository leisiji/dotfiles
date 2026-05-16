function repo_dir --description 'fzf cd into repo project directories'
    set -l dir (_repo_fzf directory)
    if test -n "$dir"
        cd "$dir"
    end
end
