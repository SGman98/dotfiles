#!/bin/bash

# Helpers
PROMPT="::BOOTSTRAP::"
log() { echo "$(date) $PROMPT $1" | tee -a "$HOME/.bootstrap.log" &>/dev/null; }
info() { echo -e "\e[1;34m$PROMPT\e[0m $1"; }
success() { echo -e "\e[1;32m$PROMPT\e[0m $1" && log "$1"; }
warn() { echo -e "\e[1;33m$PROMPT\e[0m $1"; }
important() { echo -e "\e[1;35m$PROMPT\e[0m $1"; }
abort() { echo -e "\e[1;31m$PROMPT\e[0m $1" && exit 1; }
ask() { read -rp $'\e[1;34m'"$PROMPT"$'\e[0m'" $1" RES; }
askpath() { read -rep $'\e[1;34m'"$PROMPT"$'\e[0m'" $1" RES; }
confirm() {
	DEFAULT=$([[ $2 =~ ^[Yy]?$ ]] && echo "Y" || echo "N")
	YN=$([[ $DEFAULT =~ ^[Yy]$ ]] && echo "[Y/n]" || echo "[y/N]")
	read -rsp $'\e[1;34m'"$PROMPT"$'\e[0m'" $1 $YN " -n 1 RES && echo "$RES"
	RES=$([[ $RES =~ ^[YyNn]$ ]] && echo "${RES:-$DEFAULT}" || echo "$DEFAULT")
	[[ $RES =~ ^[Yy]$ ]]
}
check_path_link() {
	LOCAL_PATH=$1
	DOTFILES_PATH=$2

	PARENTS=$(dirname "$LOCAL_PATH")
	while [[ $PARENTS != "/" ]]; do
		if [[ -L $PARENTS ]]; then
			warn "$LOCAL_PATH is inside a symlinked folder"
			confirm "Do you want to remove it?" "Y" || return 1
			rm "$PARENTS" || abort "Failed to remove $PARENTS symlink"
			success "Removed correctly"
		fi
		PARENTS=$(dirname "$PARENTS")
	done

	if [[ -L $LOCAL_PATH ]]; then
		LINK=$(readlink -f "$1")
		if ! [[ $LINK =~ ^$DOTFILES_PATH ]]; then
			warn "$LOCAL_PATH already exists and is a symlink to $LINK"
			confirm "Do you want to remove it?" "Y" || return 1
			rm "$LOCAL_PATH" || abort "Failed to remove $LOCAL_PATH symlink"
			success "Removed correctly"
		else
			success "symlink is already created correctly"
			return 0
		fi
	elif [[ -d $LOCAL_PATH ]]; then
		warn "$LOCAL_PATH already exists and is a folder"
		confirm "Do you want to backup it?" "Y" || return 1
		mv "$LOCAL_PATH" "$LOCAL_PATH.bak" || abort "Failed to backup $LOCAL_PATH folder"
		success "Backup created in $LOCAL_PATH.bak"
	elif [[ -f $LOCAL_PATH ]]; then
		warn "$LOCAL_PATH already exists and is a file"
		confirm "Do you want to backup it?" "Y" || return 1
		mv "$LOCAL_PATH" "$LOCAL_PATH.bak" || abort "Failed to backup $LOCAL_PATH file"
		success "Backup created in $LOCAL_PATH.bak"
	fi

	[[ -z $DOTFILES_PATH ]] && return 0

	info "Creating symlink $LOCAL_PATH -> $DOTFILES_PATH"
	mkdir -p "$(dirname "$LOCAL_PATH")" || abort "Failed to create folder $(dirname "$LOCAL_PATH")"
	ln -s "$DOTFILES_PATH" "$LOCAL_PATH" || abort "Failed to create symlink $LOCAL_PATH -> $DOTFILES_PATH"
	success "Symlink created correctly $LOCAL_PATH -> $DOTFILES_PATH"
}
check_package() { pacman -Qs "$1" &>/dev/null; }
install_package() {
	NAME=$1
	CONFIRM=$2
	if ! check_package "$NAME"; then
		if [[ -n $CONFIRM ]]; then
			confirm "Do you want to install $NAME" || return 1
		fi
		info "Installing $NAME"
		sudo pacman -S --noconfirm --needed "$NAME" ||
			(install_aur_helper "yay" && yay -S --noconfirm --needed "$NAME") ||
			abort "Failed to install $NAME"
		success "$NAME installed/updated with pacman"
	fi
}
install_aur_helper() {
	AUR_NAME=$1
	if ! command -v "$AUR_NAME" &>/dev/null; then
		confirm "Do you want to install $AUR_NAME?" "Y" || return 1
		git clone "https://aur.archlinux.org/$AUR_NAME.git" "/tmp/$AUR_NAME" ||
			abort "Failed to clone $AUR_NAME"
		sudo chown -R "$USER:$USER" "/tmp/$AUR_NAME" ||
			abort "Failed to change ownership of /tmp/$AUR_NAME"
		cd "/tmp/$AUR_NAME" || abort "Failed to cd to /tmp/$AUR_NAME"
		makepkg -si --noconfirm ||
			abort "Failed to install $AUR_NAME"
		cd - || abort "Failed to cd back"
		confirm "Would you like to update your system with $AUR_NAME?" "N" &&
			$AUR_NAME -Syu --noconfirm
		success "$AUR_NAME installed"
	fi
}
config_gpg() {
	if install_package "gpg"; then
		info "Creating gpg key"
		select opt in "New" "Existing"; do
			case $opt in
			"New")
				gpg --full-generate-key
				gpg --list-secret-keys --keyid-format LONG
				ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | cut -d "/" -f 2 | cut -d " " -f 1)
				important "Please copy this key and add it to github at https://github.com/settings/keys"
				gpg --armor --export "$ID"
				break
				;;
			"Existing")
				askpath "Enter path to gpg private key (leave empty to skip): "
				if [ -n "$RES" ]; then
					gpg --import "$RES"
				fi
				askpath "Enter path to gpg public key (leave empty to skip): "
				if [ -n "$RES" ]; then
					gpg --import "$RES"
				fi
				break
				;;
			*) abort "Invalid option" ;;
			esac
		done
	fi
}
config_ssh() {
	if install_package "ssh"; then
		info "Creating ssh key"
		ask "Enter your email for ssh key: "
		ssh-keygen -t ed25519 -C "$RES"
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_ed25519
		info "ssh key created"
		important "Copy this key and add it to github at https://github.com/settings/keys"
		cat ~/.ssh/id_ed25519.pub
	fi
}
manage() {
	sh "$HOME/.dotfiles/packages.sh" || abort "Failed to install packages"

	for file in "$HOME/.dotfiles/"*/manage.sh; do
		if [[ -f "$file" ]]; then
			NAME=$(basename "$(dirname "$file")")
			info "Running $1 for $NAME"
			sh "$file" "$1" || warn "Failed to run $file"
		fi
	done
}
