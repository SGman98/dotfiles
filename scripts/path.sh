#!/usr/bin/env bash

path::link() {
	local src=$1 dst=$2 parents link

	[[ -z $src ]] && log::abort "No source provided"
	[[ -z $dst ]] && log::abort "No destination provided"

	# Transform relative paths to absolute paths
	src=$(realpath -s "$src")
	dst=$(realpath -s "$dst")

	[[ -e $src ]] || log::abort "Source $src does not exist"

	parents=$(dirname "$dst")

	log::info "Recieved src=$src dst=$dst"

	while [[ $parents != "/" ]]; do
		log::info "Checking $parents"
		if [[ -L $parents ]]; then
			link=$(readlink -f "$parents")

			log::warn "$dst is inside a symlinked folder"
			log::confirm "Do you want to remove it?" "Y" || log::cancel
			rm "$parents" || log::abot "Failed to remove $parents symlink"
			log::success "Removed parent symlink $parents -> $link"
		fi
		parents=$(dirname "$parents")
	done

	log::info "Checking $dst"

	if [[ -L $dst ]]; then
		link=$(readlink -f "$dst")

		if ! [[ $link =~ $src ]]; then
			log::warn "$dst already exists and is a symlink to $link"
			log::confirm "Do you want to remove it?" "Y" || log::cancel
			rm "$dst" || log::abort "Failed to remove $dst symlink"
			log::success "Removed symlink $dst -> $link"
		else
			log::ok "Symlink $dst already points to $src"
			return 0
		fi
	elif [[ -e $dst ]]; then
		log::warn "$dst already exists"
		log::confirm "Do you want to backup it?" "Y" || log::cancel
		mv "$dst" "$dst.bak" || log::abort "Failed to backup $dst"
		log::ok "Backup created in $dst.bak"
	fi

	log::info "Creating symlink $dst -> $src"
	mkdir -p "$(dirname "$dst")" || log::abort "Failed to create folder $(dirname "$dst")"
	ln -s "$src" "$dst" || log::abort "Failed to create symlink $dst -> $src"
	log::success "Symlink created correctly $dst -> $src"
}
