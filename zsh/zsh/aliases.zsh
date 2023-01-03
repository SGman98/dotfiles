# ---- General ----
alias v="nvim"
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

# ---- Systemctl ----
alias sc="sudo systemctl"
alias scss="sudo systemctl start"
alias scst="sudo systemctl stop"

# ---- Docker ----
alias dk="docker"
alias dkcu="docker compose up"
alias dkcd="docker compose down"
alias dkcr="docker compose down && docker compose up -d --build"

