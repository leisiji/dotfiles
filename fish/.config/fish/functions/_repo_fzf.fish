function _repo_fzf --description 'Internal helper for repo directory/file selection'
    if test (count $argv) -ne 1
        return 1
    end
    set -l type $argv[1]

    # Find .repo root
    set -l root (pwd)
    while test ! -d "$root/.repo" -a "$root" != "/"
        set root (dirname "$root")
    end
    if test "$root" = "/"
        return 1
    end

    set -l hash (echo -n $root | md5sum | awk '{print $1}')
    set -l cache_file $HOME/.cache/zinit/$hash.$type.zsh
    set -l fzf_opts "--bind=ctrl-r:execute-silent(rm -f $cache_file)+reload($HOME/fzf/repo_list.sh $type $root | tee $cache_file)"

    if test -f $cache_file
        cat $cache_file | fzf $fzf_opts
    else
        $HOME/fzf/repo_list.sh $type $root | tee $cache_file | fzf $fzf_opts
    end
end
