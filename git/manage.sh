#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::git-BOOTSTRAP::"

case "$1" in
setup)
	confirm "Do you want to setup git?" "Y" || abort "Aborting..."
	install_package "git" || abort "Failed to install git"

	# Try to get GIT_USERNAME and GIT_EMAIL from git config
	GIT_USERNAME=$(git config --global user.name)
	GIT_EMAIL=$(git config --global user.email)
	GIT_SIGNINGKEY=$(git config --global user.signingkey)
	GPG_SIGNINGKEY=$(gpg --list-secret-keys --keyid-format LONG | grep sec | cut -d"/" -f2 | cut -d" " -f1)

	check_path_link "$HOME/.gitconfig"
	check_path_link "$HOME/.config/git/config" "$HOME/.dotfiles/git/config"
	check_path_link "$HOME/.config/git/gitmessage.txt" "$HOME/.dotfiles/git/gitmessage.txt"

	ask "Enter your git username$([[ -n $GIT_USERNAME ]] && echo " [$GIT_USERNAME]"): " && GIT_USERNAME=${RES:-$GIT_USERNAME}
	ask "Enter your git email$([[ -n $GIT_EMAIL ]] && echo " [$GIT_EMAIL]"): " && GIT_EMAIL=${RES:-$GIT_EMAIL}

	confirm "Your git username is $GIT_USERNAME and your git email is $GIT_EMAIL. Is it correct?" "Y" || abort "Aborting..."

	[[ -n $GIT_USERNAME ]] && echo -e "[user]\n\tname = $GIT_USERNAME" | tee -a "$HOME/.config/git/personal.gitconfig" &>/dev/null
	[[ -n $GIT_EMAIL ]] && echo -e "[user]\n\temail = $GIT_EMAIL" | tee -a "$HOME/.config/git/personal.gitconfig" &>/dev/null

	if [[ -n $GIT_SIGNINGKEY ]]; then
		confirm "Do you want to keep your signingkey in your git config [$GIT_SIGNINGKEY]?" "Y" && SIGNINGKEY="$GIT_SIGNINGKEY"
	fi
	if [[ -n $GPG_SIGNINGKEY ]] && [[ -z $SIGNINGKEY ]]; then
		confirm "Do you want to use your signingkey from gpg [$GPG_SIGNINGKEY]?" "Y" && SIGNINGKEY="$GPG_SIGNINGKEY"
	fi

	[[ -n $SIGNINGKEY ]] && echo -e "[user]\n\tsigningkey = $SIGNINGKEY" | tee -a "$HOME/.config/git/personal.gitconfig" &>/dev/null

	success "Setup correctly"
	;;
remove)
	if [[ -d $HOME/.config/git/ ]]; then
		confirm "Do you want to remove $HOME/.config/git/?" "Y" || abort "Aborting..."
		rm -rf "$HOME/.config/git/" || abort "Failed to remove $HOME/.config/git/ folder"
		success "Removed correctly"
	fi
	;;
update) ;; # TODO
*) abort "Usage: $0 {setup|remove|update}" ;;
esac
