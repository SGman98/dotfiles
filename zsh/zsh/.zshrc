eval "$(starship init zsh)"
eval $(thefuck --alias)

# ---- Include ----
source $ZDOTDIR/environment.zsh
source $ZDOTDIR/agents.zsh
source $ZDOTDIR/plugins.zsh
source $ZDOTDIR/functions.zsh
source $ZDOTDIR/aliases.zsh

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

export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND="fd --type d . --color=never --hidden"
