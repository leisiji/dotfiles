function gs --description 'git show with git-split-diffs'
    if test (count $argv) -eq 0
        echo "Usage: gs <revision>"
        return 1
    end
    git show $argv[1] | git-split-diffs --color | less -RFX
end
