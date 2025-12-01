res=$(tmux list-panes -F "#{pane_id}:#{pane_height}")
id=${res%:*}
pane_height=${res#*:}
tmp_dir="/tmp"
if [ -n "${TMPDIR}" ]; then
	tmp_dir=${TMPDIR}
fi
tmp_file=${tmp_dir}/thumbs-last
thumbs_pane_id=$(tmux new-window -P -F "#{pane_id}" -d -n "[thumbs]" "$HOME/.config/tmux/scripts/thumbs.sh ${id} ${pane_height} ${tmp_file}")
tmux swap-pane -d -s ${id} -t ${thumbs_pane_id}
