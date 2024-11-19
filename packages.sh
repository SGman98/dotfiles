#!/bin/bash

source "$HOME/.dotfiles/functions.sh"

PROMPT="::pkgs-BOOTSTRAP::"

pkgs=(
	# Essential
	# base-devel  # Base development tools # Needs fix fakeroot with --no-confirm
	wget # Download files

	# Security
	openssh # SSH server
	gnupg   # GPG

	# CLI Tools
	bat                # `cat` replacement with syntax highlighting
	bat-extras         # Bat extensions
	eza                # `ls` replacement with better formatting
	fd                 # `find` replacement faster
	fzf                # Fuzzy finder
	git-delta          # Git diff viewer
	github-cli         # Git hub cli
	htop               # Process viewer
	hurl               # HTTP requests and test
	jq                 # JSON processor
	ripgrep            # `grep` replacement faster
	thefuck            # Correct mistyped commands
	tldr               # Simplified version of `man`
	zip                # ZIP files
	unzip              # ZIP files extractor

	# Fun
	cowsay      # Cow that says things
	lolcat      # Rainbow colors
	figlet      # ASCII art
	neofetch    # System info
	fortune-mod # Random quotes
)

for pkg in "${pkgs[@]}"; do
	install_package "$pkg" || warn "Failed to install $pkg"
done

if uname -r | grep -q microsoft; then
	install_package "wsl-open" || warn "Failed to install wsl-open"
	sudo ln -s "/usr/bin/wsl-open" "/usr/bin/xdg-open" || warn "Failed to link xdg-open"
fi
