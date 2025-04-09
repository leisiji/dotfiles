# Reference: https://github.com/roosta/tmux-fuzzback
tmux_fuzzyback() {
    local content=$(tmux capture-pane -p -S -)
    local fzf_tmux=$(dirname $0)/fzf-tmux
    local line=$(echo "${content}" | awk '{print NR  " " $s}' | ${fzf_tmux} -w 80% -h 60% -p)
    line=$(echo ${line} | awk '{print $1}')
    if [[ ! -z ${line} ]]; then
        local rows=$(echo "${content}" | wc -l)
        tmux copy-mode
        let line=rows-line
        tmux send-keys -X -N "$line" cursor-up
    fi
}
tmux_fuzzyback
