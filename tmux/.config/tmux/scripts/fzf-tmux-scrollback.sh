#!bash
# Reference: https://github.com/roosta/tmux-fuzzback
tmux_fuzzyback() {
    local line=$(tmux capture-pane -p | awk '{print NR  " " $s}' | fzf-tmux ${FZF_TMUX_OPTS})
    line=$(echo ${line} | awk '{print $1}')
    if [[ -z ${line} ]]; then
        tmux copy-mode
        tmux send-keys -X -N "$line" cursor-up
    fi
}
tmux_fuzzyback
