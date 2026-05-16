#!/usr/bin/env bash
set -uo pipefail

POPUP_SESSION_NAME="${1:-popup}"

# 获取当前所在 session 名称
CURRENT_SESSION="$(tmux display-message -p -F "#{session_name}")"

# 如果已经在 popup session 中，detach 即可关闭 popup
if [ "${CURRENT_SESSION}" = "${POPUP_SESSION_NAME}" ]; then
    tmux detach-client
else
    # 否则打开 popup，attach 到已有 session，没有则创建
    tmux popup \
        -d "#{pane_current_path}" \
        -xC -yC \
        -w80% \
        -h80% \
        -E "tmux attach -t ${POPUP_SESSION_NAME} || tmux new -s ${POPUP_SESSION_NAME}"
fi
