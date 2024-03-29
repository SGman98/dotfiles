#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

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

confirm "Would you like to configure gpg?" "Y" && config_gpg
confirm "Would you like to configure ssh?" "Y" && config_ssh

manage "setup"

if ! grep -q "$PROMPT End of bootstrap script" "$HOME/bootstrap.log" &>/dev/null; then
	success "End of bootstrap script"
	info "Please restart your shell to apply changes"
	exit 0
fi
