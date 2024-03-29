#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::fish-BOOTSTRAP::"

case "$1" in
setup)
	confirm "Do you want to setup fish?" "Y" || abort "Aborting..."
	install_package "fish" || abort "Failed to install fish"

	for file in "$HOME/.dotfiles/fish/conf.d/"*; do
		check_path_link "$HOME/.config/fish/conf.d/$(basename "$file")" "$file" || abort "Failed to link $HOME/.config/fish/conf.d/$(basename "$file")"
	done

	for file in "$HOME/.dotfiles/fish/functions/"*; do
		check_path_link "$HOME/.config/fish/functions/$(basename "$file")" "$file" || abort "Failed to link $HOME/.config/fish/functions/$(basename "$file")"
	done

	check_path_link "$HOME/.config/fish/config.fish" "$HOME/.dotfiles/fish/config.fish" || abort "Failed to link $HOME/.config/fish/config.fish"
	check_path_link "$HOME/.config/fish/fish_plugins" "$HOME/.dotfiles/fish/fish_plugins" || abort "Failed to link $HOME/.config/fish/fish_plugins"

	confirm "Do you want to set fish as default shell?" "Y" &&
		(sudo chsh -s "/usr/bin/fish" "$USER" || abort "Failed to set fish as default shell")

	info "To install plugins, run: curl -sL https://git.io/fisher | source && fisher update"
	info "To apply changes, please logout and login again"

	success "Setup correctly"
	;;
remove)
	if [[ -d $HOME/.config/fish/ ]]; then
		confirm "Do you want to remove $HOME/.config/fish/?" "Y" || abort "Aborting..."
		rm -rf "$HOME/.config/fish" || abort "Failed to remove $HOME/.config/fish/ folder"
		success "Removed correctly"
	fi
	;;
*) abort "Usage: $0 {setup|remove}" ;;
esac
