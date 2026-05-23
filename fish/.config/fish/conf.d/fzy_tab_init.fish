# fzy-tab: fzy-powered tab completion for Fish shell
status is-interactive; or return 0
command -q fzy; or return 0

set -q FZY_TAB_LINES; or set -U FZY_TAB_LINES 15
set -q FZY_TAB_PROMPT; or set -U FZY_TAB_PROMPT "> "
set -q FZY_TAB_SHOW_SCORES; or set -U FZY_TAB_SHOW_SCORES 0

bind \t _fzy_tab_complete
