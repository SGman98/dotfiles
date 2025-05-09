#!/usr/bin/env bash

utils::ansi_grid() {
	local colors=("black" "red" "green" "yellow" "blue" "magenta" "cyan" "white")
	local modifiers=("regular" "bold" "dim" "italic" "underline" "blinkslow" "blinkfast" "invert" "hidden" "strikethrough")

	local max_color_length=0 max_mod_length=0

	for color in "${colors[@]}"; do
		[[ ${#color} -gt $max_color_length ]] && max_color_length="$(("${#color}" + 1))"
	done
	for mod in "${modifiers[@]}"; do
		[[ ${#mod} -gt $max_mod_length ]] && max_mod_length="$(("${#mod}" + 1))"
	done

	printf "%-*s" "$max_mod_length" "Mod/Color"
	for color in "${colors[@]}"; do
		printf "%-*s" "$max_color_length" "$color"
	done
	printf "\n"

	for mod in "${modifiers[@]}"; do
		printf "%-*s" "$max_mod_length" "$mod"
		for color in "${colors[@]}"; do
			local code code_bg reset_code code_length code_bg_length reset_length padding
			code="$(log::ansi "$color$mod")"
			code_bg="$(log::ansi "bg$color$mod")"
			reset_code="$(log::ansi reset)"
			code_length="$(echo -e "$code" | wc -c)"
			code_bg_length="$(echo -e "$code_bg" | wc -c)"
			reset_length="$(echo -e "$reset_code" | wc -c)"
			padding="$((max_color_length + code_length + code_bg_length + reset_length + 1))"
			printf "%-*s" "$padding" "$code ■ $code_bg ■ $reset_code"
		done
		printf "\n"
	done
}

utils::config_gpg() {
	if pkg::install "gpg"; then
		log::info "Creating gpg key"
		select opt in "New" "Existing"; do
			case $opt in
			"New")
				local gpg_id
				gpg --full-generate-key
				gpg --list-secret-keys --keyid-format LONG
				gpg_id=$(gpg --list-secret-keys --keyid-format LONG | grep sec | cut -d "/" -f 2 | cut -d " " -f 1)
				important "Please copy this key and add it to github at https://github.com/settings/keys"
				gpg --armor --export "$gpg_id"
				break
				;;
			"Existing")
				local private_path public_path
				log::ask -ep "Enter path to gpg private key (leave empty to skip): " private_path
				[ -n "$private_path" ] && gpg --import "$private_path"
				log::ask -ep "Enter path to gpg public key (leave empty to skip): " public_path
				[ -n "$public_path" ] && gpg --import "$public_path"
				break
				;;
			*) log::abort "Invalid option" ;;
			esac
		done
	fi
}

utils::config_ssh() {
	if pkg::install "ssh"; then
		local email
		log::info "Creating ssh key"
		log::ask -p "Enter your email for ssh key: " email
		ssh-keygen -t ed25519 -C "$email"
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/id_ed25519
		log::info "ssh key created"
		log::important "Copy this key and add it to github at https://github.com/settings/keys"
		cat ~/.ssh/id_ed25519.pub
	fi
}
