#!/usr/bin/env bash

# Helpers
PROMPT="::BOOTSTRAP::"
log() { echo "$(date) $PROMPT $1" | tee -a "$HOME/.bootstrap.log" &> /dev/null ; }
info() { echo -e "\e[1;34m$PROMPT\e[0m $1" ; }
success() { echo -e "\e[1;32m$PROMPT\e[0m $1" ; log "$1" ; }
warn() { echo -e "\e[1;33m$PROMPT\e[0m $1" ; }
abort() { echo -e "\e[1;31m$PROMPT\e[0m $1" ; exit 1 ; }
ask() { read -rp $'\e[1;34m'"$PROMPT"$'\e[0m'" $1" RES ; }
confirm() {
    DEFAULT=$([[ $2 =~ ^[Yy]?$ ]] && echo "Y" || echo "N")
    YN=$([[ $DEFAULT =~ ^[Yy]$ ]] && echo "[Y/n]" || echo "[y/N]")
    read -rsp $'\e[1;34m'"$PROMPT"$'\e[0m'" $1 $YN " -n 1 RES && echo "$RES"
    RES=$([[ $RES =~ ^[YyNn]$ ]] && echo "${RES:-$DEFAULT}" || echo "$DEFAULT")
    [[ $RES =~ ^[Yy]$ ]]
}
check_path_link() {
    LOCAL_PATH=$1
    DOTFILES_PATH=$2

    PARENTS=$(dirname "$LOCAL_PATH")
    while [[ $PARENTS != "/" ]] ; do
        if [[ -L $PARENTS ]] ; then
            warn "$LOCAL_PATH is inside a symlinked folder"
            confirm "Do you want to remove it?" "Y" || return 1
            rm "$PARENTS" || abort "Failed to remove $PARENTS symlink"
            success "Removed correctly"
        fi
        PARENTS=$(dirname "$PARENTS")
    done
    
    if [[ -L $LOCAL_PATH ]] ; then
        LINK=$(readlink -f "$1")
        if ! [[ $LINK =~ ^$DOTFILES_PATH ]] ; then
            warn "$LOCAL_PATH already exists and is a symlink to $LINK" 
            confirm "Do you want to remove it?" "Y" || return 1
            rm "$LOCAL_PATH" || abort "Failed to remove $LOCAL_PATH symlink"
            success "Removed correctly"
        else
            success "symlink is already created correctly"
            return 0
        fi
    elif [[ -d $LOCAL_PATH ]] ; then
        warn "$LOCAL_PATH already exists and is a folder"
        confirm "Do you want to backup it?" "Y" || return 1
        mv "$LOCAL_PATH" "$LOCAL_PATH.bak" || abort "Failed to backup $LOCAL_PATH folder"
        success "Backup created in $LOCAL_PATH.bak"
    elif [[ -f $LOCAL_PATH ]] ; then
        warn "$LOCAL_PATH already exists and is a file"
        confirm "Do you want to backup it?" "Y" || return 1
        mv "$LOCAL_PATH" "$LOCAL_PATH.bak" || abort "Failed to backup $LOCAL_PATH file"
        success "Backup created in $LOCAL_PATH.bak"
    fi

    [[ -z $DOTFILES_PATH ]] && return 0
    
    info "Creating symlink $LOCAL_PATH -> $DOTFILES_PATH"
    mkdir -p "$(dirname "$LOCAL_PATH")" || abort "Failed to create folder $(dirname "$LOCAL_PATH")"
    ln -s "$DOTFILES_PATH" "$LOCAL_PATH" || abort "Failed to create symlink $LOCAL_PATH -> $DOTFILES_PATH"
    success "Symlink created correctly $LOCAL_PATH -> $DOTFILES_PATH"
}
check_package() { pacman -Qs "$1" &> /dev/null ; }
install_package() {
    NAME=$1
    CONFIRM=$2
    if [[ -n $CONFIRM ]] ; then
        confirm "Do you want to install $NAME" || return 1
    fi
    info "Installing $NAME"
    sudo pacman -S --noconfirm --needed "$NAME" || abort "Failed to install $NAME with pacman"
    success "$NAME installed with pacman" 
}
manage() {
    # First install all packages
    sh "$HOME/.dotfiles/packages.sh" || abort "Failed to install packages"
    
    for file in "$HOME/.dotfiles/"*/manage.sh ; do
        if [[ -f "$file" ]] ; then
            NAME=$(basename "$(dirname "$file")")
            info "Running $1 for $NAME"
            sh "$file" "$1" || abort "Failed to run $file"
        fi
    done
}
 