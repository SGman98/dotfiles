#!/bin/bash

# shellcheck source=/dev/null
source "$HOME/.dotfiles/functions.sh"

PROMPT="::pkgs-BOOTSTRAP::"

pkgs=(
    # Essential
    base-devel # Base development tools
    wget       # Download files

    # Controlled with dotfiles
    git        # Version control
    fish       # Shell
    starship   # Shell prompt
    neovim     # Text editor
    tmux       # Terminal multiplexer
    
    # Security
    openssh   # SSH server
    gnupg     # GPG
    
    # CLI Tools
    bat        # Cat clone with syntax highlighting
    exa        # ls clone
    fd         # Find files
    fzf        # Fuzzy finder
    ripgrep    # Search files
    jq         # JSON parser
    htop       # Process viewer
    thefuck    # Correct mistyped commands
    git-delta     # Git diff viewer

    # Fun
    cowsay    # Cow that says things
    lolcat    # Rainbow colors
    figlet    # ASCII art
    neofetch  # System info
    fortune   # Random quotes
)

for pkg in "${pkgs[@]}"; do
    info "Installing $pkg..."
    install_package "$pkg" "yes" || warn "Failed to install $pkg"
done