function gp --description 'Git push current branch'
    set -l branch (git branch --show-current)
    git push origin $branch:$branch
end
