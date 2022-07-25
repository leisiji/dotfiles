ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# emacs key
bindkey -e
bindkey '^w' vi-backward-kill-word
bindkey '\ew' backward-kill-word

alias ni=nvim; alias t='tmux -2'; alias ta='tmux -2 a'
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
export FZF_TMUX_OPTS="-p"
export GTAGSLABEL='native-pygments'
export GOPROXY='https://goproxy.io,direct'
#export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
#export JAVA_HOME="/usr/lib/jvm/java-16-openjdk"
#export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

# plugin config
export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# gentoo prefix
GENTOO_PREFIX=""
if [ -d $HOME/gentoo ]; then
	GENTOO_PREFIX=$HOME/gentoo
fi
export GTAGSCONF="$GENTOO_PREFIX/usr/share/gtags/gtags.conf"
zinit ice wait"1" lucid; zinit snippet $GENTOO_PREFIX/usr/share/fzf/key-bindings.zsh
zinit ice wait"1" lucid; zinit snippet $GENTOO_PREFIX/usr/share/fzf/completion.zsh

zinit wait="1" lucid for OMZ::plugins/extract/extract.plugin.zsh

zinit light skywind3000/z.lua
zpcompinit; zpcdreplay

zinit wait="1" lucid light-mode for \
	zsh-users/zsh-autosuggestions \
	hlissner/zsh-autopair \
	zdharma-continuum/fast-syntax-highlighting \
	zsh-users/zsh-completions \
	Aloxaf/fzf-tab \
	wfxr/forgit

bindkey '^[,' autosuggest-accept

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -l $realpath'
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:files' sort false
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

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
	local dirs=$(fd --type d --maxdepth 1 --hidden)
	if [[ -z "$dirs" ]]; then
		my_exe "exa -l"
		return 0
	fi
	local dir
	if [[ $(echo ${dirs} | wc -w) -eq 1 ]]; then
		dir=${dirs}
	else
		dir="$(echo ${dirs} | fzf --reverse --height 40%)"
		if [[ -z "$dir" ]]; then
			zle redisplay
			return 0
		fi
	fi
	my_exe "cd ${dir}"
	unset dir
}
zle -N my-fzf-cd
bindkey '\ej' my-fzf-cd

bindkey -s '\eq' 'cd ..\n'
bindkey -s '\el' 'exa -l\n'
bindkey -s '\es' 'git status .\n'

# hint of the completion of task by tmux
precmd () {
	echo -n -e "\a"
}

PROMPT='
%~
> '

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
