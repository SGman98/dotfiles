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

	# RTX
	rtx

	# CLI Tools
	bat                # `cat` replacement with syntax highlighting
	bat-extras         # Bat extensions
	exa                # `ls` replacement with better formatting
	fd                 # `find` replacement faster
	fzf                # Fuzzy finder
	git-delta          # Git diff viewer
	gitflow-avh        # Git flow command tool
	github-cli         # Git hub cli
	htop               # Process viewer
	hurl-bin           # HTTP requests and test
	jq                 # JSON processor
	nodejs-live-server # basic http server with live reloading
	ripgrep            # `grep` replacement faster
	thefuck            # Correct mistyped commands
	tldr               # Simplified version of `man`
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
