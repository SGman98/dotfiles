#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::mise-BOOTSTRAP::"

case "$1" in
setup)
	confirm "Do you want to setup mise?" "Y" || abort "Aborting..."
	install_package "mise" || abort "Failed to install mise"

	check_path_link "$HOME/.config/mise/config.toml" "$HOME/.dotfiles/mise/config.toml"

	success "Setup correctly"
	;;
remove)
	if [[ -d $HOME/.config/mise/ ]]; then
		confirm "Do you want to remove $HOME/.config/mise/?" "Y" || abort "Aborting..."
		rm -rf "$HOME/.config/mise/" || abort "Failed to remove $HOME/.config/mise/ folder"
		success "Removed correctly"
	fi
	;;
*) abort "Usage: $0 {setup|remove}" ;;
esac
