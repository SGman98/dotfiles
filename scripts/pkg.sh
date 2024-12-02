#!/usr/bin/env bash

# TODO: improve this
os::get() {
	local release distros
	release="$(cat /etc/*-release)"
	distros=("Arch" "Debian" "Ubuntu")

	for distro in "${distros[@]}"; do
		if [[ $release == *"$distro"* ]]; then
			echo "$distro"
			return
		fi
	done

	log::abort "Unknown OS"
}

pkg::check() {
	[[ ! -v 1 ]] && log::abort "No package provided"
	local pkg="$1"

	case "$(os::get)" in
		Arch) pacman -Qs "$pkg" &>/dev/null ;;
		Debian | Ubuntu) dpkg -s "$pkg" &>/dev/null ;;
		*) log::abort "Unknown OS" ;;

	esac
}

pkg::install_cmd() {
	[[ ! -v 1 ]] && log::abort "No package provided"
	local pkg="$1"

	case "$(os::get)" in
		Arch)
			log::info "Installing $pkg with pacman"
			if ! sudo pacman -S --noconfirm --needed "$pkg"; then
				log::warn "Failed to install $pkg with pacman"
				log::confirm "Do you want to install with yay?" || log::cancel
				pkg::install_aur_helper "yay" || log::abort "Failed to install yay"
				yay -S --noconfirm --needed "$pkg" || log::abort "Failed to install $pkg"
			fi
			;;
		Debian | Ubuntu)
			log::info "Installing $pkg with apt"
			sudo apt-get install -y "$pkg" || log::abort "Failed to install $pkg"
			;;
	esac
}

pkg::uninstall_cmd() {
	[[ ! -v 1 ]] && log::abort "No package provided"
	local pkg="$1"

	case "$(os::get)" in
		Arch)
			log::info "Uninstalling $pkg with pacman"
			sudo pacman -R --noconfirm "$pkg" || log::abort "Failed to uninstall $pkg"
			;;
		Debian | Ubuntu)
			log::info "Uninstalling $pkg with apt"
			sudo apt-get remove -y "$pkg" || log::abort "Failed to uninstall $pkg"
			;;
	esac
}

pkg::install() {
	local confirm=false force=false

	local usage_cmd usage_help usage_options parsed
	usage_cmd="$(basename "$0")"
	usage_cmd="${usage_cmd:+"$usage_cmd run pkg::install"}"
	usage_help+="[-c] [-f] <package>"
	usage_options+="-c, --confirm Confirm installation\n"
	usage_options+="-f, --force Force reinstallation\n"

	parsed="$(getopt -o cf -l confirm,force -n "$usage_cmd" -- "$@")" || log::usage
	eval set -- "$parsed"
	while true; do
		case "$1" in
			-c | --confirm) confirm=true && shift ;;
			-f | --force) force=true && shift ;;
			--) shift && break ;;
			*) log::usage "Not implemented: $1" ;;
		esac
	done

	[[ ! -v 1 ]] && log::abort "No package provided"
	local pkg="$1"

	if pkg::check "$pkg"; then
		if [[ $force == true ]]; then
			log::info "Reinstalling $pkg"
			pkg::install_cmd "$pkg" || log::abort "Failed to reinstall $pkg"
			log::success "$pkg reinstalled"
		else
			log::ok "$pkg is already installed"
		fi
	else
		if [[ $confirm == true ]]; then
			log::confirm "Do you want to install $pkg" || log::cancel
		fi
		pkg::install_cmd "$pkg" || log::abort "Failed to install $pkg"
		log::success "$pkg installed"
	fi
}

pkg::uninstall() {
	local confirm=false

	local usage_cmd usage_help usage_options parsed
	usage_cmd="$(basename "$0")"
	usage_cmd="${usage_cmd:+"$usage_cmd run pkg::install"}"
	usage_help+="[-c] <package>"
	usage_options+="-c, --confirm Confirm uninstallation\n"

	parsed="$(getopt -o c -l confirm -n "$usage_cmd" -- "$@")" || log::usage
	eval set -- "$parsed"
	while true; do
		case "$1" in
			-c | --confirm) confirm=true && shift ;;
			--) shift && break ;;
			*) log::usage "Not implemented: $1" ;;
		esac
	done

	[[ ! -v 1 ]] && log::abort "No package provided"
	local pkg="$1"

	if ! pkg::check "$pkg"; then
		log::ok "$pkg is not installed"
	else
		if [[ $confirm == true ]]; then
			log::confirm "Do you want to uninstall $pkg" || log::cancel
		fi
		pkg::uninstall_cmd "$pkg" || log::abort "Failed to uninstall $pkg"
		log::success "$pkg uninstalled"
	fi
}

pkg::install_aur_helper() {
	[[ ! -v 1 ]] && log::abort "No aur helper name provided"
	local aur_name="$1"
	if ! command -v "$aur_name" &>/dev/null; then
		log::confirm "Do you want to install $aur_name" || log::cancel
		git clone "https://aur.archlinux.org/$aur_name.git" "/tmp/$aur_name" || log::abort "Failed to clone $aur_name"
		sudo chown -R "$USER:$USER" "/tmp/$aur_name" || log::abort "Failed to change ownership of /tmp/$aur_name"
		cd "/tmp/$aur_name" || log::abort "Failed to cd to /tmp/$aur_name"
		makepkg -si --noconfirm || log::abort "Failed to install $aur_name"
		cd - || log::abort "Failed to cd back"

		log::confirm "Would you like to update your system with $aur_name?" "N" && "$aur_name" -Syu --noconfirm
		log::success "$aur_name aur helper installed"
	else
		log::ok "$aur_name is already installed"
	fi
}
