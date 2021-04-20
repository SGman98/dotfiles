# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="custom"

# plugins=(git)
    plugins=(zsh-autosuggestions git-flow-completion)
    source $ZSH/oh-my-zsh.sh

# User configuration
    alias vimrc="vim ~/.vimrc"
    alias zshrc="vim ~/.zshrc && source ~/.zshrc"
    alias gotoC="cd /mnt/c/"
    alias gotoD="cd /mnt/d/"
    alias p="cd /mnt/d/Documents/Programming"

# Git aliases
    alias gs='git status'
    alias gpp='git pull && git push'
    alias gcm='git commit'
    alias ga='git add -A'
    alias gco='git checkout'

    alias gdot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
    alias gdota='gdot add'
    alias gdots='gdot status'
    alias gdotcm='gdot commit'
    alias gdotpp='gdot pull && gdot push'

# Vim in terminal
    bindkey -v
    bindkey "jk" vi-cmd-mode

# Functions
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
