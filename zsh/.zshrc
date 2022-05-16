# zmodload zsh/zprof
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles
# For use of gpg signing
export GPG_TTY=$(tty)

# For ssh use
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

# Theme selection
export VIRTUAL_ENV_DISABLE_PROMPT=1
ZSH_THEME="custom"

# plugins=(git)
    plugins=(zsh-vi-mode git-flow-completion zsh-syntax-highlighting)
    source $ZSH/oh-my-zsh.sh
    DISABLE_UNTRACKED_FILES_DIRTY="true"

# User configuration
    alias gotoC="cd /mnt/c/"
    alias gotoD="cd /mnt/d/"
    alias p="cd /mnt/d/Documents/programming"
    alias l="ls -lAhX"
# Useful
    alias py="python3"
    alias v="nvim"
    alias bat="batcat"
    alias g="git"

# Git aliases for dotfiles
    alias vimrc="v $DOTFILES/nvim/.config/nvim/lua/user/init.lua"
    alias zshrc="v $DOTFILES/zsh/.zshrc && source $HOME/.zshrc"
    alias gitconfig="v $DOTFILES/git/.config/git/config"

# Postgresql
    alias pg_start="sudo pg_ctlcluster 12 main start"
# Functions
    # mkdir and cd
    function mdcd() {
        mkdir -p -- "$1" && cd -P -- "$1"
    }
    # Auto activate virtual enviroment if exist
    function cd() {
      builtin cd "$@"

      if [[ -z "$VIRTUAL_ENV" ]] ; then
        ## If env folder is found then activate the vitualenv
          if [[ -d ./.venv ]] ; then
            source ./.venv/bin/activate
          fi
      else
        ## check the current folder belong to earlier VIRTUAL_ENV folder
        # if yes then do nothing
        # else deactivate
          parentdir="$(dirname "$VIRTUAL_ENV")"
          if [[ "$PWD"/ != "$parentdir"/* ]] ; then
            deactivate
          fi
      fi
    }
    # The plugin will auto execute this zvm_before_init function
    function zvm_before_init() {
        zvm_bindkey viins '^[[A' history-beginning-search-backward
        zvm_bindkey viins '^[[B' history-beginning-search-forward
        zvm_bindkey vicmd '^[[A' history-beginning-search-backward
        zvm_bindkey vicmd '^[[B' history-beginning-search-forward
    }
    # Comp init just once a day
    autoload -Uz compinit
    for dump in ~/.zcompdump(N.mh+24); do
      compinit
    done
    compinit -C

#zprof
PATH="$HOME/.local/bin:$PATH"

# nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
