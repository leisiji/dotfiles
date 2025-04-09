#!/usr/bin/env bash

FLOAX_SESSION_NAME='scratch'

envvar_value() {
    tmux showenv -g "$1" | cut -d '=' -f 2-
}

pop() {
    FLOAX_WIDTH=$(envvar_value FLOAX_WIDTH)
    FLOAX_HEIGHT=$(envvar_value FLOAX_HEIGHT)

    FLOAX_TITLE=$(envvar_value FLOAX_TITLE)
    if [ -z "$FLOAX_TITLE" ]; then
        FLOAX_TITLE="$DEFAULT_TITLE"
    fi

    FLOAX_SESSION_NAME=$(envvar_value FLOAX_SESSION_NAME)
    if [ -z "$FLOAX_SESSION_NAME" ]; then
        FLOAX_SESSION_NAME="$DEFAULT_SESSION_NAME"
    fi

    tmux set-option -t "$FLOAX_SESSION_NAME" detach-on-destroy on
    tmux popup \
        -S fg="$FLOAX_BORDER_COLOR" \
        -s fg="$FLOAX_TEXT_COLOR" \
        -T "$FLOAX_TITLE" \
        -w "$FLOAX_WIDTH" \
        -h "$FLOAX_HEIGHT" \
        -b rounded \
        -E \
        "tmux attach-session -t \"$FLOAX_SESSION_NAME\""
}

tmux_popup() {
    # TODO: make this optional:
    current_dir=$(tmux display -p '#{pane_current_path}')
    scratch_path=$(tmux display -t scratch -p '#{pane_current_path}')
    if [ "$scratch_path" != "$current_dir" ] && [ "$FLOAX_CHANGE_PATH" = "true" ]; then
        tmux send-keys -R -t "$FLOAX_SESSION_NAME" " cd $current_dir" C-m
    fi

	if ! pop; then
		tmux setenv -g FLOAX_WIDTH "80%"
		tmux setenv -g FLOAX_HEIGHT "80%"
		pop
	fi
}

if [ "$(tmux display-message -p '#{session_name}')" = "$FLOAX_SESSION_NAME" ]; then
    if [ -z "$FLOAX_TITLE" ]; then
        FLOAX_TITLE="$DEFAULT_TITLE"
    fi

    if [ -z "$FLOAX_SESSION_NAME" ]; then
        FLOAX_SESSION_NAME="$DEFAULT_SESSION_NAME"
    fi

    change_popup_title "$FLOAX_TITLE"
    tmux setenv -g FLOAX_TITLE "$FLOAX_TITLE"
    tmux detach-client
else
    # Check if the session 'scratch' exists
    if tmux has-session -t "$FLOAX_SESSION_NAME" 2>/dev/null; then
        tmux_popup
    else
        # Create a new session named 'scratch' and attach to it
        tmux new-session -d -c "$(tmux display-message -p '#{pane_current_path}')" -s "$FLOAX_SESSION_NAME"
        tmux set-option -t "$FLOAX_SESSION_NAME" status off
        tmux_popup
    fi
fi
