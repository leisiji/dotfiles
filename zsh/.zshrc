### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
	command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
	command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# emacs key
bindkey -e
bindkey '^w' vi-backward-kill-word
bindkey '\ew' backward-kill-word

alias ni=nvim; alias t='tmux -2'; alias ta='tmux -2 a'
alias cr='cd $(git rev-parse --show-toplevel)'
alias jdtls="$HOME/.config/nvim/jdtls.sh"
export TERM=xterm-256color
export TERM_ITALICS=true
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export MANPAGER='nvim +Man!'
export EDITOR='nvim'
export PATH="$PATH:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.cargo/bin"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d'
export FZF_DEFAULT_OPTS='--ansi --tabstop=1 --bind ctrl-d:half-page-down,ctrl-u:half-page-up,tab:down,ctrl-p:toggle-preview,ctrl-e:preview-down,ctrl-y:preview-up --reverse --cycle --preview-window=hidden:65%'
export GTAGSLABEL='native-pygments'
export GOPROXY='https://goproxy.io,direct'

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
	zdharma/fast-syntax-highlighting \
	zsh-users/zsh-completions \
	Aloxaf/fzf-tab \
	wfxr/forgit

bindkey '^[,' autosuggest-accept

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -l $realpath'
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':completion:files' sort false

# 补全 bat
addBat () {
	RBUFFER="${t} | bat"
}
zle -N addBat
bindkey '\ea' addBat
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
