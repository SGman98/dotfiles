#!/usr/bin/env bash

# shellcheck source=/dev/null
source "$HOME/.dotfiles/functions.sh"

PROMPT="::starship-BOOTSTRAP::"

case "$1" in
    setup)
        confirm "Do you want to setup starship?" "Y" || abort "Aborting..."
        install_package "starship" || abort "Failed to install starship"

        check_path_link "$HOME/.config/starship/config.toml" "$HOME/.dotfiles/starship/config.toml"
        ;;
    remove)
        if [[ -d $HOME/.config/starship/ ]] ; then
            confirm "Do you want to remove $HOME/.config/starship/?" "Y" || abort "Aborting..."
            rm -rf "$HOME/.config/starship/" || abort "Failed to remove $HOME/.config/starship/ folder"
            success "Removed correctly"
        fi
        ;;
    update) ;; # TODO
    *) abort "Usage: $0 {setup|remove|update}" ;;
esac