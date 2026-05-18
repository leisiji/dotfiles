function gp --description 'Git push current branch'
    set -l branch (git branch --show-current)

    # Detect repo workspace by walking up looking for .repo/
    set -l dir (git rev-parse --show-toplevel 2>/dev/null)
    set -l is_repo false
    while test -n "$dir" -a "$dir" != "/"
        if test -d "$dir/.repo"
            set is_repo true
            break
        end
        set dir (dirname $dir)
    end

    if test "$is_repo" = true
        git push origin $branch:refs/for/$branch
    else
        git push origin $branch:$branch
    end
end
