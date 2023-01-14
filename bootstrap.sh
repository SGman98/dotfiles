#!/bin/bash

# Load helper functions
curl -s https://raw.githubusercontent.com/SGman98/.dotfiles/master/functions.sh >/tmp/functions.sh
source /tmp/functions.sh && rm /tmp/functions.sh

info "Starting bootstrap script..."

info "Make sure to have base-devel and git installed"
info "Set you ssh and gpg keys before running this script"

# Ask for root privileges
if [[ $EUID -ne 0 ]]; then
	info "This script may require root privileges, please enter your password"
	sudo -v || abort "Failed to get root privileges"
fi

# Check pacman is installed
command -v pacman &>/dev/null || abort "Pacman is not installed"

# Clone dotfiles repo
if [[ -d "$HOME/.dotfiles" ]]; then
	warn "Dotfiles repo already exists"
	if confirm "Do you want to update dotfiles?" "Y"; then
		info "Updating dotfiles..."
		manage "update"
	elif confirm "Do you want to change dotfiles? (it will move the existing dotfiles repo to $HOME/.dotfiles.bak)" "N"; then
		info "Changing dotfiles..."
		manage "remove"
		mv "$HOME/.dotfiles" "$HOME/.dotfiles.bak" || abort "Failed to move existing dotfiles repo check if $HOME/.dotfiles.bak already exists"
		sed -i "s/$PROMPT End of bootstrap script/$PROMPT DEPRECATED End of bootstrap script/g" "$HOME/.bootstrap.log" &>/dev/null || abort "Failed to update bootstrap log"
		success "Old dotfiles repo moved to $HOME/.dotfiles.bak"
	fi
fi

if [[ ! -d "$HOME/.dotfiles" ]]; then
	REPO_URL="git@github.com:SGman98/.dotfiles.git"

	info "Cloning dotfiles repo $REPO_URL into $HOME/.dotfiles ..."

	git clone "$REPO_URL" "$HOME/.dotfiles" || abort "Failed to clone dotfiles repo"
	success "Dotfiles repo cloned"

	manage "setup"

	if ! grep -q "$PROMPT End of bootstrap script" "$HOME/bootstrap.log" &>/dev/null; then
		success "End of bootstrap script"
		info "Please restart your shell to apply changes"
		info "Then run this script with the following command:"
		info "sh $HOME/.dotfiles/bootstrap.sh"
		exit 0
	fi
fi
