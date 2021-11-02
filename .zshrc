# zmodload zsh/zprof
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
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
ZSH_THEME="custom"

# plugins=(git)
    plugins=(git-flow-completion zsh-syntax-highlighting)
    source $ZSH/oh-my-zsh.sh
    DISABLE_UNTRACKED_FILES_DIRTY="true"

# User configuration
    alias vimrc="vim ~/.config/vim/vimrc"
    alias zshrc="vim ~/.zshrc && source ~/.zshrc"
    alias gotoC="cd /mnt/c/"
    alias gotoD="cd /mnt/d/"
    alias p="cd /mnt/d/Documents/programming"
# Useful
    alias py="python3"

# Git aliases
    alias gst='git status'
    alias gpl='git pull'
    alias gph='git push'
    alias gplph='git pull && git push'
    alias gcm='git commit'
    alias ga='git add -A'
    alias gco='git checkout'

    alias gdot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
    alias gdota='gdot add'
    alias gdotst='gdot status'
    alias gdotcm='gdot commit'
    alias gdotplph='gdot pull && gdot push'

    alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

    # stashing
    alias gs="git stash"
    alias gsp="git stash pop"
    alias gsu="git stash -u"
    alias gl="git stash list"
    alias gll="git stash-list"
    alias glll="git stash-list --full"
    alias gss="git stash save"


# Vim in terminal
    bindkey -v
    export KEYTIMEOUT=1
    # bindkey 'jk' vi-cmd-mode

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
    # Comp init just once a day
    autoload -Uz compinit
    for dump in ~/.zcompdump(N.mh+24); do
      compinit
    done
    compinit -C

export VIMINIT='source $MYVIMRC'
export MYVIMRC='~/.config/vim/vimrc'  #Config vimrc path
#zprof
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
