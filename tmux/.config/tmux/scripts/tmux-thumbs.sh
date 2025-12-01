res=$(tmux list-panes -F \"#{pane_id}:#{pane_height}\")
id=${res%:*}
pane_height=${res#*:}
thumbs_pane_id=$(tmux new-window -P -F "#{pane_id}" -d -n "[thumbs]" "tmux capture-pane -t ${id} -p | tail -n ${pane_height} | thumbs -f '%U:%H' -t /tmp/thumbs-last; tmux swap-pane -t ${id}; tmux wait-for -S thumbs-finished")
echo ${id} ${thumbs_pane_id}
tmux swap-pane -d -s ${id} -t ${thumbs_pane_id}
