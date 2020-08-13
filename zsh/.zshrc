# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
	command mkdir -p $HOME/.zinit
	command git clone https://github.com/zdharma/zinit $HOME/.zinit/bin
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias ni=nvim
alias ra=ranger
alias tmux='tmux -2'
alias ls=exa
export TERM=xterm-256color
export TERM_ITALICS=true
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export MANPAGER='nvim +Man!'
export PATH="$PATH:$HOME/.local/bin/"

# key-bindings 放在前面，防止后面的快捷键被覆盖
zplugin snippet OMZ::lib/key-bindings.zsh
zplugin snippet OMZ::lib/completion.zsh
zplugin ice wait'0' lucid; zplugin snippet OMZ::plugins/extract/extract.plugin.zsh
zplugin ice wait'0' lucid; zplugin snippet OMZ::plugins/fzf/fzf.plugin.zsh
#zplugin ice wait'0' lucid; zplugin snippet OMZ::plugins/sudo/sudo.plugin.zsh
zplugin ice wait'0' lucid; zplugin snippet OMZ::plugins/git/git.plugin.zsh

zplugin light romkatv/powerlevel10k
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-autosuggestions
zplugin light skywind3000/z.lua
zplugin ice blockf; zplugin light zsh-users/zsh-completions
zplugin ice wait'0' lucid; zplugin light hlissner/zsh-autopair
zplugin ice wait'1' lucid; zplugin light wfxr/forgit
zplugin ice wait'0' lucid; zplugin light zsh-users/zsh-history-substring-search

export ZSH_AUTOSUGGEST_USE_ASYNC="true"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
bindkey ',' autosuggest-execute
bindkey '^[,' autosuggest-accept

# 初始化补全
zpcompinit; zpcdreplay

# 补全 bat
addBat () {
	text_to_add=" | bat"
	RBUFFER=${text_to_add}${RBUFFER}
}
zle -N addBat
bindkey '^[a' addBat
bindkey -s '\eq'   'cd ..\n'
bindkey -s '\el'   'ls -l\n'
bindkey -s '\ee' 'ni '
bindkey -s '\ew' 'cd '

