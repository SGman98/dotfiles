#!/usr/bin/env bash

# shellcheck source=/dev/null
source "$HOME/.dotfiles/functions.sh"

PROMPT="::tmux-BOOTSTRAP::"

case "$1" in
    setup)
        confirm "Do you want to setup tmux?" "Y" || abort "Aborting..."
        install_package "tmux" || abort "Failed to install tmux"

        check_path_link "$HOME/.config/tmux/tmux.conf" "$HOME/.dotfiles/tmux/tmux.conf"
        git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"

        info "When you start tmux, press prefix + I to install plugins"
        ;;
    remove)
        if [[ -d $HOME/.config/tmux/ ]] ; then
            confirm "Do you want to remove $HOME/.config/tmux/?" "Y" || abort "Aborting..."
            rm -rf "$HOME/.config/tmux/" || abort "Failed to remove $HOME/.config/tmux/ folder"
            success "Removed correctly"
        fi
        ;;
    update) ;; # TODO
    *) abort "Usage: $0 {setup|remove|update}" ;;
esac