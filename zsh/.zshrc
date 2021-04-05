# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
	command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
	command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
	zinit-zsh/z-a-rust \
	zinit-zsh/z-a-as-monitor \
	zinit-zsh/z-a-patch-dl \
	zinit-zsh/z-a-bin-gem-node

alias ni=nvim
alias t='tmux -2'
alias ta='tmux -2 a'
alias ls=exa
alias cr='cd $(git rev-parse --show-toplevel)'
export TERM=xterm-256color
export TERM_ITALICS=true
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export MANPAGER='nvim +Man!'
export EDITOR='nvim'
export PATH="$PATH:$HOME/.local/bin/:$HOME/.yarn/bin/:$HOME/.cargo/bin/"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d'
export FZF_DEFAULT_OPTS='--ansi --bind ctrl-d:half-page-down,ctrl-u:half-page-up,tab:down,ctrl-p:toggle-preview --reverse --cycle'

# key-bindings 放在前面，防止后面的快捷键被覆盖
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/completion.zsh
zinit ice wait'0' lucid; zinit snippet OMZ::plugins/extract/extract.plugin.zsh
#zinit ice wait'0' lucid; zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh
zinit snippet /usr/share/fzf/key-bindings.zsh
zinit snippet /usr/share/fzf/completion.zsh
#zinit ice wait'0' lucid; zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit ice wait'0' lucid; zinit snippet OMZ::plugins/git/git.plugin.zsh

# zlua shoud be put before completion init
zinit light skywind3000/z.lua
# 初始化补全
zpcompinit; zpcdreplay
# fzf-tab should be put after completion init, and before
# syntax-highligt, autosuggestions
zinit light Aloxaf/fzf-tab

zinit light romkatv/powerlevel10k
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit ice blockf; zinit light zsh-users/zsh-completions
zinit ice wait'0' lucid; zinit light hlissner/zsh-autopair
zinit ice wait'1' lucid; zinit light wfxr/forgit
zinit ice wait'0' lucid; zinit light zsh-users/zsh-history-substring-search

export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
bindkey '^[,' autosuggest-accept

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

# 补全 bat
addBat () {
	text_to_add=" | bat"
	RBUFFER=${text_to_add}${RBUFFER}
}
zle -N addBat
bindkey '^[a' addBat
bindkey -s '\eq' 'cd ..\n'
bindkey -s '\el' 'ls -l\n'
bindkey -s '\ev' 'ni '
bindkey -s '\es' 'gst .\n'

# hint of the completion of task by tmux
precmd () {
	echo -n -e "\a"
}
