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
	bat                # Cat clone with syntax highlighting
	bat-extras         # Bat extensions
	exa                # ls clone
	fd                 # Find files
	fzf                # Fuzzy finder
	git-delta          # Git diff viewer
	gitflow-avh        # Git flow command tool
	github-cli         # Git hub cli
	htop               # Process viewer
	hurl-bin           # HTTP requests and test
	jq                 # JSON parser
	ripgrep            # Search files
	thefuck            # Correct mistyped commands
	tldr               # Simple help for tools
	nodejs-live-server # Live server

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
