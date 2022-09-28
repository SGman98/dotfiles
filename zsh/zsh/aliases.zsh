# ---- General ----
alias l="ls -lAhX --color=auto"
alias c="clear"
alias md="mkdir -p"
alias rd="rmdir"
mdcd() { mkdir -p -- "$1" && cd -P -- "$1"; };



alias dots="$EDITOR $DOTFILES"

# ---- Git ----
alias g="git"

# ---- Python ----
alias py="python3"
alias pyenv="python -m venv"

# ---- Pacman ----
alias pac="sudo pacman"