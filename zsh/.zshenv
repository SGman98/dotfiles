# ---- Default editors ----
export EDITOR="nvim"
export VISUAL="nvim"

# ---- XDG ----
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

# ---- Fix paths ----
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME/docker-machine"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

# ---- FZF ----
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND="fd --type d . --color=never --hidden"
export FZF_ALT_C_OPTS="--preview 'tree --dirsfirst -ifFClL 1 {} | grep -v /$ | head -50'"

# Add local bin to path
export PATH=/home/sg/.local/bin:$PATH 
