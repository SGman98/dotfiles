#!/bin/bash

# shellcheck source=../functions.sh
source "$HOME/.dotfiles/functions.sh"

PROMPT="::thefuck-BOOTSTRAP::"

case "$1" in
	setup)
		confirm "Do you want to setup thefuck?" "Y" || abort "Aborting..."
		install_package "thefuck" || abort "Failed to install thefuck"

		check_path_link "$HOME/.config/thefuck/settings.py" "$HOME/.dotfiles/thefuck/settings.py"

		success "Setup correctly"
		;;
	remove)
		if [[ -d $HOME/.config/thefuck/ ]]; then
			confirm "Do you want to remove $HOME/.config/thefuck/?" "Y" || abort "Aborting..."
			rm -rf "$HOME/.config/thefuck/" || abort "Failed to remove $HOME/.config/thefuck/ folder"
			success "Removed correctly"
		fi
		;;
	*) abort "Usage: $0 {setup|remove}" ;;
esac
