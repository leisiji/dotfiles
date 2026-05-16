function repo_files --description 'fzf open repo project files'
    set -l file (_repo_fzf file)
    if test -n "$file"
        nvim $file
    end
end
