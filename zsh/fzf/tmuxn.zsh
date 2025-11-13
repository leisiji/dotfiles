_forgit_get_single_file_from_diff_line() {
    # Similar to the function above, but only gets a single file from a single line
    # Gets the new name of renamed files
    sed 's/^[[:space:]]*\[[A-Z0-9]*\][[:space:]]*//' | sed 's/.*->  //'
}

local input_line rootdir
input_line=$1
rootdir=$(git rev-parse --show-toplevel)
filename=$(echo "$input_line" | _forgit_get_single_file_from_diff_line)
tmux popup -w 90% -h 90% -E "cd $rootdir && nvim $rootdir/$filename"
