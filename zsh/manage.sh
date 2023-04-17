#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::zsh-BOOTSTRAP::"

case "$1" in
setup)
	confirm "Do you want to setup zsh?" "Y" || abort "Aborting..."
	install_package "zsh" || abort "Failed to install zsh"

	grep -q "ZDOTDIR=$HOME/.config/zsh" /etc/zsh/zshenv || echo "ZDOTDIR=$HOME/.config/zsh" | sudo tee -a /etc/zsh/zshenv

	check_path_link "$HOME/.config/zsh/custom" "$HOME/.dotfiles/zsh/custom" || abort "Failed to link $HOME/.config/zsh/custom"
	check_path_link "$HOME/.config/zsh/.zshrc" "$HOME/.dotfiles/zsh/.zshrc" || abort "Failed to link $HOME/.config/zsh/.zshrc"
	check_path_link "$HOME/.config/zsh/.zshenv" "$HOME/.dotfiles/zsh/.zshenv" || abort "Failed to link $HOME/.config/zsh/.zshenv"

	confirm "Do you want to set zsh as default shell?" "Y" &&
		(sudo chsh -s "/usr/bin/zsh" "$USER" || abort "Failed to set zsh as default shell")

	info "To apply changes, please logout and login again"

	success "Setup correctly"
	;;
remove)
	if [[ -d $HOME/.config/zsh/ ]]; then
		confirm "Do you want to remove $HOME/.config/zsh/?" "Y" || abort "Aborting..."
		rm -rf "$HOME/.config/zsh/" || abort "Failed to remove $HOME/.config/zsh/ folder"
		success "Removed correctly"
	fi
	;;
*) abort "Usage: $0 {setup|remove}" ;;
esac
