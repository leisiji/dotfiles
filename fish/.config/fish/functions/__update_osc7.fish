function __update_osc7 --on-variable PWD --on-event fish_prompt
    set -l host (hostname 2>/dev/null; or echo "localhost")
    set -l url_path (string escape --style=url $PWD)
    printf "\e]7;file://%s%s\e\\" $host $url_path
end
