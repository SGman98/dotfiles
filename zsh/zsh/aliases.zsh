# ---- General ----
alias l="ls -lAhX --color=auto"
alias c="clear"
alias md="mkdir -p"
alias rd="rmdir"
mdcd() { mkdir -p -- "$1" && cd -P -- "$1"; };
reload() { source $ZDOTDIR/.zshenv; source $ZDOTDIR/.zshrc; }

alias dots="$EDITOR $DOTFILES"

# ---- Git ----
alias g="git"

# ---- Python ----
alias py="python3"
alias pyenv="python -m venv"

# ---- Pacman ----
alias pac="sudo pacman"

# ---- Docker ----
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcr="docker compose down && docker compose up -d --build"
