#!/usr/bin/env bash

# shellcheck source=../functions.sh
source "$HOME/.dotfiles/functions.sh"

PROMPT="::neovim-BOOTSTRAP::"

case "$1" in
	setup)
		confirm "Do you want to setup neovim?" "Y" || abort "Aborting..."
		install_package "neovim" || abort "Failed to install neovim"

		# Older setups linked each item into a real ~/.config/nvim: remove those
		# links and move its local files (e.g. spell/) into the repo
		if [[ -d $HOME/.config/nvim && ! -L $HOME/.config/nvim ]]; then
			info "Migrating $HOME/.config/nvim to a single symlink"
			shopt -s nullglob dotglob
			for item in "$HOME/.config/nvim"/*; do
				if [[ -L $item && $(readlink -f "$item") == "$HOME/.dotfiles/nvim/"* ]]; then
					rm "$item"
				elif [[ -e $HOME/.dotfiles/nvim/$(basename "$item") ]]; then
					warn "$(basename "$item") exists in both, leaving it in the backup"
				else
					mv "$item" "$HOME/.dotfiles/nvim/" || abort "Failed to move $item"
				fi
			done
			shopt -u nullglob dotglob
			rmdir "$HOME/.config/nvim" 2>/dev/null
		fi
		check_path_link "$HOME/.config/nvim" "$HOME/.dotfiles/nvim"

		success "Setup correctly"
		;;
	remove)
		if [[ -d $HOME/.config/nvim/ ]]; then
			confirm "Do you want to remove $HOME/.config/nvim/?" "Y" || abort "Aborting..."
			rm -rf "$HOME/.config/nvim/" || abort "Failed to remove $HOME/.config/nvim/ folder"
			success "Removed correctly"
		fi
		;;
	*) abort "Usage: $0 {setup|remove}" ;;
esac
