res=$(tmux list-panes -F "#{pane_id}:#{pane_height}")
id=${res%:*}
pane_height=${res#*:}
tmp_dir="/tmp"
if [ -n ${TMPDIR} ]; then
	tmp_dir=${TMPDIR};
fi
tmp_file=${tmp_dir}/thumbs-last
thumbs_pane_id=$(tmux new-window -P -F "#{pane_id}" -d -n "[thumbs]" "tmux capture-pane -t ${id} -p | tail -n ${pane_height} | thumbs --hint-fg-color red -f '%U:%H' -t ${tmp_file}; tmux swap-pane -t ${id}; tmux wait-for -S thumbs-finished; tmux set-buffer -w $(thumbs_out=$(cat ${TMPDIR}/thumbs-last);thumbs_target=${thumbs_out#*:};echo ${thumbs_target})")
tmux swap-pane -d -s ${id} -t ${thumbs_pane_id}
