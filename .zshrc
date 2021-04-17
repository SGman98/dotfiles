# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="custom"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
alias vimvimrc="vim ~/.vimrc"
alias vimzshrc="vim ~/.zshrc && source ~/.zshrc"
alias gotoC="cd /mnt/c/"
alias gotoD="cd /mnt/d/"
alias gotoProgramming="cd /mnt/d/Documents/Programming"
# Git aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias gs='git status'
alias gpp='git pull && git push'
alias gcm='git commit'
alias ga='git add -A'
alias gco='git checkout'

