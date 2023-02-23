#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::alacritty-BOOTSTRAP::"

case "$1" in
setup)
	confirm "Do you want to setup alacritty?" "Y" || abort "Aborting..."
	install_package "alacritty" || abort "Failed to install alacritty"

	check_path_link "$HOME/.config/alacritty/alacritty.yml" "$HOME/.dotfiles/alacritty/alacritty.yml"

	success "Setup correctly"
	;;
remove)
	if [[ -d $HOME/.config/alacritty/ ]]; then
		confirm "Do you want to remove $HOME/.config/alacritty/?" "Y" || abort "Aborting..."
		rm -rf "$HOME/.config/alacritty" || abort "Failed to remove $HOME/.config/alacritty folder"
		success "Removed correctly"
	fi
	;;
*) abort "Usage: $0 {setup|remove}" ;;
esac
