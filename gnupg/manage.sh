#!/usr/bin/env bash

# shellcheck source=../functions.sh
source "$HOME/.dotfiles/functions.sh"

PROMPT="::gnupg-BOOTSTRAP::"

case "$1" in
	setup)
		confirm "Do you want to setup gnupg?" "Y" || abort "Aborting..."
		install_package "gnupg" || abort "Failed to install gnupg"

		# Link the file, not ~/.gnupg: that folder holds the private keys
		check_path_link "$HOME/.gnupg/gpg-agent.conf" "$HOME/.dotfiles/gnupg/gpg-agent.conf"
		chmod 700 "$HOME/.gnupg"
		gpg-connect-agent reloadagent /bye &>/dev/null

		success "Setup correctly"
		;;
	remove)
		if [[ -L $HOME/.gnupg/gpg-agent.conf ]]; then
			confirm "Do you want to remove $HOME/.gnupg/gpg-agent.conf?" "Y" || abort "Aborting..."
			rm "$HOME/.gnupg/gpg-agent.conf" || abort "Failed to remove $HOME/.gnupg/gpg-agent.conf"
			success "Removed correctly"
		fi
		;;
	*) abort "Usage: $0 {setup|remove}" ;;
esac
