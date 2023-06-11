#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::rtx-BOOTSTRAP::"

case "$1" in
setup)
	confirm "Do you want to setup rtx?" "Y" || abort "Aborting..."
	install_package "rtx" || abort "Failed to install rtx"

	check_path_link "$HOME/.config/rtx/config.toml" "$HOME/.dotfiles/rtx/config.toml"

	success "Setup correctly"
	;;
remove)
	if [[ -d $HOME/.config/rtx/ ]]; then
		confirm "Do you want to remove $HOME/.config/rtx/?" "Y" || abort "Aborting..."
		rm -rf "$HOME/.config/rtx/" || abort "Failed to remove $HOME/.config/rtx/ folder"
		success "Removed correctly"
	fi
	;;
*) abort "Usage: $0 {setup|remove}" ;;
esac
