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
	bat         # Cat clone with syntax highlighting
	bat-extras  # Bat extensions
	exa         # ls clone
	fd          # Find files
	fzf         # Fuzzy finder
	ripgrep     # Search files
	jq          # JSON parser
	htop        # Process viewer
	thefuck     # Correct mistyped commands
	git-delta   # Git diff viewer
	gitflow-avh # Git flow command tool
   	github-cli  # Git hub cli

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
