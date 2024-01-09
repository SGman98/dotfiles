#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::git-BOOTSTRAP::"

case "$1" in
setup)
	confirm "Do you want to setup git?" "Y" || abort "Aborting..."
	install_package "git" || abort "Failed to install git"

	check_path_link "$HOME/.gitconfig"
	check_path_link "$HOME/.config/git/config" "$HOME/.dotfiles/git/config"
	check_path_link "$HOME/.config/git/ignore" "$HOME/.dotfiles/git/ignore"

	if [[ -z $(git config --global --includes user.name) ]]; then
		ask "Enter your git username: " &&
			echo -e "[user]\n\tname = $RES" | tee -a "$HOME/.config/git/personal.gitconfig" &>/dev/null
	fi

	if [[ -z $(git config --global --includes user.email) ]]; then
		ask "Enter your git email: " &&
			echo -e "[user]\n\temail = $RES" | tee -a "$HOME/.config/git/personal.gitconfig" &>/dev/null
	fi

	GIT_SIGNINGKEY=$(git config --global --includes user.signingkey)
	GPG_SIGNINGKEY=$(gpg --list-secret-keys --keyid-format LONG | grep sec | cut -d"/" -f2 | cut -d" " -f1)
	if [[ -z $GIT_SIGNINGKEY ]] && [[ -n $GPG_SIGNINGKEY ]]; then
		confirm "Do you want to use your signingkey from gpg [$GPG_SIGNINGKEY]?" "Y" &&
			echo -e "[user]\n\tsigningkey = $GPG_SIGNINGKEY" | tee -a "$HOME/.config/git/personal.gitconfig" &>/dev/null
	fi

	success "Setup correctly"
	;;
remove)
	if [[ -d $HOME/.config/git/ ]]; then
		confirm "Do you want to remove $HOME/.config/git/?" "Y" || abort "Aborting..."
		rm -rf "$HOME/.config/git/" || abort "Failed to remove $HOME/.config/git/ folder"
		success "Removed correctly"
	fi
	;;
*) abort "Usage: $0 {setup|remove}" ;;
esac
