# ---- Personal ----
export DOTFILES=$HOME/.dotfiles

# ---- ZSH ----
export HISTFILE="$XDG_DATA_HOME/zsh/history"

export HISTSIZE=5000
export SAVEHIST=5000
export HISTDUP=erase

if [ ! -d "$XDG_CONFIG_HOME/zsh" ]; then
    mkdir -p "$XDG_CONFIG_HOME/zsh"
fi
if [ ! -d "$XDG_DATA_HOME/zsh" ]; then
    mkdir -p "$XDG_DATA_HOME/zsh"
fi
