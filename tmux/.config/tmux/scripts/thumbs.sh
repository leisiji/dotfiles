id=$1
pane_height=$2
tmp_file=$3
tmux capture-pane -t ${id} -p | tail -n ${pane_height} | thumbs --hint-fg-color red -t ${tmp_file}
tmux swap-pane -t ${id}
tmux wait-for -S thumbs-finished
tmux set-buffer -w $(cat ${tmp_file})
