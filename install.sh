#!/usr/bin/env bash

usage() {
    cat << EOF
    Usage: $0 [options]
    Options:
        -h, --help       Display this help message
        -i, --install    Install all packages
        -o, --others     Install oh-my-zsh, nvim, nvm, nvim-others
        -c, --clean      Clean all installed packages
        -s, --stow       Stow all installed install_packages
        -a, --all        Install all packages and stow them
EOF
}

install_packages() {
    # install zsh
    sudo apt update && sudo apt upgrade
    sudo apt install stow\
    build-essential\
    cmake\
    curl\
    python3.8-dev\
    zsh\
    pandoc\
    texlive-full\
    texlive-latex-extra\
    bat\
    tree\
    neofetch
}

install_oh_my_zsh() {
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # install plugins
    git clone https://github.com/bobthecow/git-flow-completion $ZSH/custom/plugins/git-flow-completion
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode
}

install_nvm_node() {
    # install nvm and node
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    nvm install node
}

install_nvim() {
    # install nvim 0.6
    curl -L https://github.com/neovim/neovim/releases/download/v0.6.0/nvim.appimage > nvim.appimage
    chmod +x nvim.appimage
    ./nvim.appimage --appimage-extract
    mv squashfs-root / && ln -s /squashfs-root/AppRun /usr/bin/nvim
    rm nvim.appimage
    npm install -g neovim
}

install_nvim_others() {
    # install ripgrep
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
    sudo dpkg -i ripgrep_13.0.0_amd64.deb

    # install fd-menu
    sudo apt install fd-find
}

clean() {
    # remove nvim if exists
    if [ -z "$(which nvim)" ]; then
        rm $(which nvim)
    fi

    # if .zshrc exists, delete in
    if [ -f $HOME/.zshrc ]; then
        rm $HOME/.zshrc
    fi
    # if .gitconfig exists, delete it
    if [ -f $HOME/.gitconfig ]; then
        rm $HOME/.gitconfig
    fi
    # if .config git not exists, create it
    if [ ! -d $HOME/.config/git ]; then
        mkdir -p $HOME/.config/git
    fi
    # if .config nvim not exists, create it
    if [ ! -d $HOME/.config/nvim ]; then
        mkdir -p $HOME/.config/nvim
    fi
}

stow () {
    stow -v -t $HOME zsh git nvim
}

while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -i|--install)
            install_packages
            exit 0
            ;;
        -o|--others)
            install_oh_my_zsh
            install_nvim
            install_nvm_node
            install_nvim_others
            exit 0
            ;;
        -c|--clean)
            clean
            exit 0
            ;;
        -s|--stow)
            stow
            exit 0
            ;;
        -a|--all)
            install_packages
            install_oh_my_zsh
            install_nvim
            install_nvm_node
            install_nvim_others
            stow
            exit 0
            ;;
        *)
            echo "Invalid option: $1"
            usage
            exit 1
            ;;
    esac
    shift
done

