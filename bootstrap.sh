#!/usr/bin/env bash

# Helpers
PROMPT="::BOOTSTRAP::"
log() { echo "$(date) $PROMPT $1" | tee -a "$HOME/.bootstrap.log" ; }
info() { echo -e "\e[1;34m$PROMPT\e[0m $1" ; }
success() { echo -e "\e[1;32m$PROMPT\e[0m $1" ; log "$1" ; }
warn() { echo -e "\e[1;33m$PROMPT\e[0m $1" ; }
abort() { echo -e "\e[1;31m$PROMPT\e[0m $1" ; exit 1 ; }
confirm() {
    DEFAULT=$([[ $2 =~ ^[Yy]?$ ]] && echo "Y" || echo "N")
    YN=$([[ $DEFAULT =~ ^[Yy]$ ]] && echo "[Y/n]" || echo "[y/N]")
    read -rsp $'\e[1;34m'"$PROMPT"$'\e[0m'" $1 $YN " -n 1 RES && echo "$RES"
    REPLY=$([[ $RES =~ ^[YyNn]$ ]] && echo "${RES:-$DEFAULT}" || echo "$DEFAULT")
    [[ $RES =~ ^[Yy]$ ]]
}

# Ask for root privileges
if [[ $EUID -ne 0 ]] ; then
    info "This script may require root privileges, please enter your password"
    sudo -v || abort "Failed to get root privileges"
fi

# Check pacman is installed
command -v pacman &> /dev/null || abort "Pacman is not installed"

confirm "Would you like to update your system?" "N" && sudo pacman -Syu --noconfirm && success "System updated"

# Install base packages
pacman -Qs base-devel &> /dev/null || (confirm "Would you like to install base-devel?" "Y" && sudo pacman -S base-devel && success "base-devel installed")
pacman -Qs git &> /dev/null || (confirm "Would you like to install git?" "Y" && sudo pacman -S git && success "git installed")

# Clone dotfiles repo
if [[ -d "$HOME/.dotfiles" ]] ; then
    warn "Dotfiles repo already exists"
    confirm "Want to change dotfiles? (it will move the existing dotfiles repo to $HOME/.dotfiles.bak)" "N" || abort "Aborting..."

    # Run down scripts for all configs in dotfiles
    for file in "$HOME/.dotfiles"/*/down.sh ; do
        if [[ -f "$file" ]] ; then
            info "Running $file"
            sh "$file" || abort "Failed to run $file"
        fi
    done

    mv "$HOME/.dotfiles" "$HOME/.dotfiles.bak" || abort "Failed to move existing dotfiles repo"
    sed -i "s/$PROMPT End of bootstrap script/$PROMPT DEPRECATED End of bootstrap script/g" "$HOME/.bootstrap.log" &> /dev/null || abort "Failed to update bootstrap log"
    success "Existing dotfiles repo moved to $HOME/.dotfiles.bak"
fi

info "Please enter your github username and repo name (e.g. username/repo_name)"
read -r USER_REPO
USER="${USER_REPO%/*}"
REPO="${USER_REPO#*/}"
SSH_URL="git@github.com:$USER/$REPO.git"

info "Cloning dotfiles repo $USER_REPO into $HOME/.dotfiles"

git clone "$SSH_URL" "$HOME/.dotfiles" || abort "Failed to clone dotfiles repo"
success "Dotfiles repo cloned"

# Run up scripts for all configs in dotfiles
for file in "$HOME/.dotfiles"/*/up.sh ; do
    if [[ -f "$file" ]] ; then
        info "Running $file"
        sh "$file" || abort "Failed to run $file"
    fi
done

if ! grep -q "$PROMPT End of bootstrap script" "$HOME/bootstrap.log" &> /dev/null ; then
    success "End of bootstrap script"
    info "Please restart your shell to apply changes"
    info "Then run this script with the following command:"
    info "sh $HOME/.dotfiles/bootstrap.sh"
    exit 0
fi

# Second part of bootstrap script
# Coming soon...