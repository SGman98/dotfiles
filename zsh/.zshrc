eval "$(starship init zsh)"
eval $(thefuck --alias)

if [[ -z "$TMUX" ]]; then
    tmux attach -t main &>/dev/null || tmux new -s main
    exit
fi

# ---- Include ----
source $ZDOTDIR/custom/environment.zsh
source $ZDOTDIR/custom/agents.zsh
source $ZDOTDIR/custom/plugins.zsh
source $ZDOTDIR/custom/functions.zsh
source $ZDOTDIR/custom/aliases.zsh

fortune | cowsay -W"$(( $(stty size | cut -d" " -f2) - 3 ))" | lolcat -F 0.01

# ---- ZSH ----
setopt hist_find_no_dups
setopt hist_ignore_all_dups

setopt autocd # Auto change directory when typing a directory name

# ignore case when tab-completing
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# menu selection highlighting
zstyle ':completion:*' menu select

bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# # ---- FZF ----
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
