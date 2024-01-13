### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# emacs key
bindkey -e
bindkey '^w' vi-backward-kill-word
bindkey '\ew' backward-kill-word

alias ni=nvim; alias j=joshuto; alias t='tmux -2'; alias ta='tmux -2 a'
alias cr='cd $(git rev-parse --show-toplevel)'
export TERM=xterm-256color
export TERM_ITALICS=true
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export MANPAGER='nvim +Man!'
export EDITOR='nvim'
export PATH="$PATH:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.cargo/bin"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix'
export FZF_DEFAULT_OPTS='--ansi --tabstop=1 --bind ctrl-d:half-page-down,ctrl-u:half-page-up,tab:down,ctrl-p:toggle-preview,alt-j:preview-down,alt-k:preview-up --reverse --cycle --preview-window=hidden:65%'
export GTAGSLABEL='native-pygments'
export GOPROXY='https://goproxy.io,direct'
#export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
#export JAVA_HOME="/usr/lib/jvm/java-16-openjdk"
#export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

# plugin config
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# gentoo prefix
zinit snippet $HOME/fzf-key-bindings.zsh
zinit snippet $HOME/fzf-completion.zsh
zinit wait="1" lucid for OMZP::extract

zpcompinit; zpcdreplay

zinit wait lucid light-mode for \
    zsh-users/zsh-autosuggestions \
    hlissner/zsh-autopair \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-completions \
    Aloxaf/fzf-tab \
    wfxr/forgit

eval "$(zoxide init zsh)"

bindkey '^[,' autosuggest-accept

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':completion:files' sort false

my_exe() {
    zle push-line
    BUFFER="$1"
    zle accept-line
}

# 补全 bat
addBat () {
    RBUFFER="${t} | bat"
    zle accept-line
}
zle -N addBat
bindkey '\ea' addBat

my-fzf-cd() {
    local dirs=$(find -maxdepth 1 -type d)
    dir=$(echo ${dirs} | fzf --reverse --height 40%)
    if [[ ! -z ${dir} ]]; then
        my_exe "cd ${dir}"
    else
        zle redisplay
    fi
    unset dir
}
zle -N my-fzf-cd
bindkey '\ej' my-fzf-cd

bindkey -s '\eq' 'cd ..\n'
bindkey -s '\el' 'exa -l\n'
bindkey -s '\es' 'git status .\n'

precmd () {
    echo -n -e "\a"
}

PROMPT='
%~
> '

if [[ -n $TERMUX_APP_PID ]]; then
    sshd
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
