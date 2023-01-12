#!/usr/bin/env bash

# Load helper functions
curl -s https://raw.githubusercontent.com/SGman98/.dotfiles/master/functions.sh > /tmp/functions.sh
# shellcheck source=/dev/null
source /tmp/functions.sh && rm /tmp/functions.sh

info "Starting bootstrap script..."

# Ask for root privileges
if [[ $EUID -ne 0 ]] ; then
    info "This script may require root privileges, please enter your password"
    sudo -v || abort "Failed to get root privileges"
fi

# Check pacman is installed
command -v pacman &> /dev/null || abort "Pacman is not installed"

confirm "Do you want to update your system?" "N" && sudo pacman -Syu --noconfirm && success "System updated"

# Install base packages
install_package "base-devel" "yes" || abort "base-devel is required"
install_package "git" "yes" || abort "git is required"

if ! check_package "openssh"; then
    install_package "openssh" "yes" || abort "openssh is required"
    info "Creating ssh key"
    ask "Enter your email for ssh key: " && email=$RES
    ssh-keygen -t ed25519 -C "$email" || abort "Failed to generate ssh key"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519 || abort "Failed to add ssh key"
    success "ssh key created"
    info "Copy this key and add it to github at https://github.com/settings/keys"
    info "Key > $(cat ~/.ssh/id_ed25519.pub)"
    read -rsp "Press any key to continue..." -n 1 && echo
fi

# Clone dotfiles repo
if [[ -d "$HOME/.dotfiles" ]] ; then
    warn "Dotfiles repo already exists"
    if confirm "Do you want to update dotfiles?" "Y" ; then
        info "Updating dotfiles..."
        manage "update"
    elif confirm "Do you want to change dotfiles? (it will move the existing dotfiles repo to $HOME/.dotfiles.bak)" "N" ; then
        info "Changing dotfiles..."
        manage "remove"
        mv "$HOME/.dotfiles" "$HOME/.dotfiles.bak" || abort "Failed to move existing dotfiles repo check if $HOME/.dotfiles.bak already exists"
        sed -i "s/$PROMPT End of bootstrap script/$PROMPT DEPRECATED End of bootstrap script/g" "$HOME/.bootstrap.log" &> /dev/null || abort "Failed to update bootstrap log"
        success "Old dotfiles repo moved to $HOME/.dotfiles.bak"
    fi
fi

if [[ ! -d "$HOME/.dotfiles" ]] ; then
    # info "Please enter your github username and repo name (e.g. username/repo_name)"
    # read -r USER_REPO
    # USER="${USER_REPO%/*}"
    # REPO="${USER_REPO#*/}"
    # SSH_URL="git@github.com:$USER/$REPO.git"
    SSH_URL="git@github.com:SGman98/.dotfiles.git"

    info "Cloning dotfiles repo $SSH_URL into $HOME/.dotfiles ..."

    git clone "$SSH_URL" "$HOME/.dotfiles" || abort "Failed to clone dotfiles repo"
    success "Dotfiles repo cloned"

    manage "setup"

    if ! grep -q "$PROMPT End of bootstrap script" "$HOME/bootstrap.log" &> /dev/null ; then
        success "End of bootstrap script"
        info "Please restart your shell to apply changes"
        info "Then run this script with the following command:"
        info "sh $HOME/.dotfiles/bootstrap.sh"
        exit 0
    fi
fi

# Second part of bootstrap script
# Coming soon...
