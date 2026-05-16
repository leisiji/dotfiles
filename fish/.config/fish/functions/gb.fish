function gb --description 'Git pull with rebase'
    git stash
    git pull origin (git branch --show-current) --rebase
    git stash pop --quiet
end
