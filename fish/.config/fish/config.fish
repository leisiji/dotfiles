# ========== Environment Variables ==========
set -gx TERM xterm-256color
set -gx TERM_ITALICS true
set -gx MANPAGER 'nvim +Man!'
set -gx EDITOR nvim
set -gx PATH $PATH $HOME/.bun/bin $HOME/.cargo/bin $HOME/go/bin
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd --type d --strip-cwd-prefix'
set -gx FZF_DEFAULT_OPTS '--ansi --tabstop=1 --bind=ctrl-d:half-page-down,ctrl-u:half-page-up,tab:down,ctrl-p:toggle-preview,alt-j:preview-down,alt-k:preview-up --reverse --cycle --preview-window=hidden:65%'
set -gx FORGIT_FZF_DEFAULT_OPTS "-m --bind alt-w:select"
set -gx GTAGSLABEL native-pygments
set -gx GOPROXY https://goproxy.io,direct
set -gx FLUTTER_STORAGE_BASE_URL https://mirrors.tuna.tsinghua.edu.cn/flutter
set -gx RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static
set -gx fish_prompt_pwd_dir_length 0

# ========== Aliases ==========
alias ni nvim
alias t 'tmux -2 -u'
alias ta 'tmux -2 -u a'
alias cr 'cd (git rev-parse --show-toplevel)'
alias gt 'gitui -t macchiato.ron'
alias claude 'claude --dangerously-skip-permissions'
alias vscode-json-language-server vscode-json-languageserver

if test -f ~/local_path.fish
    source ~/local_path.fish
end

# ========== fzf integration ==========
if type -q fzf
    fzf --fish | source
end

# ========== Shell integrations ==========
# starship init fish | source
# atuin init fish | source
zoxide init fish | source

# ========== Event handlers ==========
function __precmd_bell --on-event fish_prompt
    echo -n \a
end

# ========== Key binding helpers ==========
function __bind_cd_up
    commandline -r 'cd ..'
    commandline -f execute
end

function __bind_eza
    commandline -r 'eza -l --icons=always'
    commandline -f execute
end

function __bind_clear
    commandline -r 'clear'
    commandline -f execute
end

function __bind_git_status
    commandline -r 'git status .'
    commandline -f execute
end

function __bind_git_status_fzf
    set -lx FZF_DEFAULT_COMMAND "git status -uno -s"
    set -l item (fzf -m < /dev/tty | awk '{print $2}')
    if test -n "$item"
        commandline -i " $item"
    end
    commandline -f repaint
end

# ========== Key Bindings ==========
bind \ew backward-kill-bigword
bind \e, accept-autosuggestion

bind \eq __bind_cd_up
bind \el __bind_eza
bind \cl __bind_clear
bind \es __bind_git_status
bind \er nh
bind \ej repo_dir
bind \eu repo_files
bind \et __bind_git_status_fzf

# ========== Hydro prompt ==========
set -g hydro_symbol_prompt '➜'
set -g hydro_color_pwd blue
set -g hydro_color_git brblack
set -g hydro_color_prompt green
set -g hydro_color_error red
set -g hydro_multiline true

# ========== Conditional ==========
if set -q TERMUX_APP_PID
    sshd
end
