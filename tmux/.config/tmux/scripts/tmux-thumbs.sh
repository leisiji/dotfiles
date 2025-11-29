copy2osc52() {
    if IFS= read -r input; then
        local ENCODED_DATA
        ENCODED_DATA=$(printf "%s" "$input" | base64 | tr -d '\n')
        printf '\033]52;c;%s\007' "$ENCODED_DATA"
    fi
}

tmux capture -p | $HOME/.cargo/bin/thumbs -u -r | copy2osc52
