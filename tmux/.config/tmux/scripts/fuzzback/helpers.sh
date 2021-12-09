# returns a string unique to current pane
# sed removes `$` sign because `session_id` contains is
_pane_unique_id() {
  tmux display-message -p "#{session_id}-#{window_index}-#{pane_index}" |
    sed 's/\$//'
}

get_tmp_dir() {
  echo "${TMPDIR:-/tmp}/tmux-$EUID-fuzzback"
}

get_tmp_filename() {
  echo "$(get_tmp_dir)/tmp-$(_pane_unique_id)"
}

get_capture_filename() {
  echo "$(get_tmp_dir)/capture-$(_pane_unique_id)"
}

get_tail_filename() {
  echo "$(get_tmp_dir)/tail-$(_pane_unique_id)"
}

get_head_filename() {
  echo "$(get_tmp_dir)/head-$(_pane_unique_id)"
}

delete_old_files() {
  local c h t
  c="$(get_capture_filename)"
  h="$(get_head_filename)"
  t="$(get_tail_filename)"
  rm -f "$c" "$h" "$t"
}

# $1: option
# $2: default value
# Source: https://github.com/wfxr/tmux-fzf-url/blob/b8436ddcab9bc42cd110e0d0493a21fe6ed1537e/fzf-url.tmux#L11
tmux_get() {
  local value
  value="$(tmux show -gqv "$1")"
  [ -n "$value" ] && echo "$value" || echo "$2"
}
