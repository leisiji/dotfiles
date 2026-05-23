function _fzy_tab_complete --description 'fzy-powered tab completion'
    # Get command line state
    set -l cmd (commandline -c)
    set -l token (commandline -ct)

    # Skip fzy-tab for zoxide commands, use default completion instead
    set -l first_word (string split ' ' -- $cmd)[1]
    if contains -- $first_word z zi zoxide
        commandline -f complete
        return
    end

    # Get completions: each line is "completion\tdescription"
    set -l candidates (complete -C "$cmd" 2>/dev/null)
    set -l count (count $candidates)

    if test $count -eq 0
        commandline -f repaint
        return
    end

    # Single candidate: accept directly
    if test $count -eq 1
        set -l comp (string split \t -- $candidates[1])[1]
        commandline -t -- $comp
        set -l expanded (string replace -r '^~' "$HOME" -- $comp)
        if not test -d $expanded
            commandline -i ' '
        end
        commandline -f repaint
        return
    end

    # Calculate fzy height (fzy requires at least 3 lines)
    set -l lines $FZY_TAB_LINES
    test $lines -gt $count; and set lines $count
    test $lines -lt 3; and set lines 3

    # Run fzy
    set -l flags -q "$token" -p "$FZY_TAB_PROMPT" -l $lines
    test "$FZY_TAB_SHOW_SCORES" = 1; and set -a flags -s

    set -l selection (printf '%s\n' $candidates | fzy $flags < /dev/tty)

    if test -z "$selection"
        commandline -f repaint
        return
    end

    # Extract completion text (before tab)
    set -l comp (string split \t -- $selection)[1]
    commandline -t -- $comp
    set -l expanded (string replace -r '^~' "$HOME" -- $comp)
    if not test -d $expanded
        commandline -i ' '
    end
    commandline -f repaint
end
