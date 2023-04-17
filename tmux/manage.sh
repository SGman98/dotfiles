#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::tmux-BOOTSTRAP::"

case "$1" in
setup)
	confirm "Do you want to setup tmux?" "Y" || abort "Aborting..."
	install_package "tmux" || abort "Failed to install tmux"
	install_package "tmuxinator" || abort "Failed to install tmuxinator"

	check_path_link "$HOME/.config/tmux/tmux.conf" "$HOME/.dotfiles/tmux/tmux.conf"
	if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
		git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
	fi

	info "When you start tmux, press prefix + I to install plugins"

	success "Setup correctly"
	;;
remove)
	if [[ -d $HOME/.config/tmux/ ]]; then
		confirm "Do you want to remove $HOME/.config/tmux/?" "Y" || abort "Aborting..."
		rm -rf "$HOME/.config/tmux/" || abort "Failed to remove $HOME/.config/tmux/ folder"
		success "Removed correctly"
	fi
	;;
*) abort "Usage: $0 {setup|remove}" ;;
esac
