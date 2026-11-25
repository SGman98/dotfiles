#!/bin/bash

# shellcheck source=../functions.sh
source "$HOME/.dotfiles/functions.sh"

PROMPT="::markdownlint-BOOTSTRAP::"

case "$1" in
	setup)
		confirm "Do you want to setup markdownlint?" "Y" || abort "Aborting..."

		# markdownlint-cli falls back to this when the project has no config of its own
		check_path_link "$HOME/.config/markdownlint/config" "$HOME/.dotfiles/markdownlint/config"

		success "Setup correctly"
		;;
	remove)
		if [[ -d $HOME/.config/markdownlint/ ]]; then
			confirm "Do you want to remove $HOME/.config/markdownlint/?" "Y" || abort "Aborting..."
			rm -rf "$HOME/.config/markdownlint/" || abort "Failed to remove $HOME/.config/markdownlint/ folder"
			success "Removed correctly"
		fi
		;;
	*) abort "Usage: $0 {setup|remove}" ;;
esac
