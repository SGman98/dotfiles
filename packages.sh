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
	bat        # `cat` replacement with syntax highlighting
	bat-extras # Bat extensions
	eza        # `ls` replacement with better formatting
	fd         # `find` replacement faster
	fzf        # Fuzzy finder
	git-delta  # Git diff viewer
	github-cli # Git hub cli
	htop       # Process viewer
	hurl       # HTTP requests and test
	jq         # JSON processor
	ripgrep    # `grep` replacement faster
	thefuck    # Correct mistyped commands
	tldr       # Simplified version of `man`
	typst      # Simplified TeX
	unzip      # ZIP files extractor
	zip        # ZIP files

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

# ssh-agent as a systemd user socket, keys are added on first use
if command -v systemctl &>/dev/null && systemctl --user list-unit-files ssh-agent.socket &>/dev/null; then
	systemctl --user enable --now ssh-agent.socket || warn "Failed to enable ssh-agent.socket"
fi
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
if ! grep -qs "AddKeysToAgent" "$HOME/.ssh/config"; then
	printf '\nHost *\n    AddKeysToAgent yes\n' >>"$HOME/.ssh/config"
	chmod 600 "$HOME/.ssh/config"
fi
