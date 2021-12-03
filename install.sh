#!/usr/bin/env bash

usage() {
    cat << EOF
    Usage: $0 [options]
    Options:
        -h, --help       Display this help message
        -i, --install    Install all packages and oh-my-zsh
        -u, --install2   Install nvm and oh-my-zsh plugins
        -s, --stow       Stow all installed install_packages
        -o, --others     Install oh-my-zsh, nvim, nvm, nvim-others
EOF
}

install_packages() {
    # install zsh
    echo "Installing packages..."
    sudo -s apt update
    sudo -s apt upgrade
    sudo -s apt install stow\
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
    echo "Done!"
}

install_oh_my_zsh() {
    # install oh-my-zsh
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_oh_my_zsh_plugins() {
    # install plugins
    git clone https://github.com/bobthecow/git-flow-completion $ZSH/custom/plugins/git-flow-completion
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode
}

install_nvm_node() {
    # install nvm and node
    echo "Installing nvm and node"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
}

install_nvm_2() {
    nvm install node
}

install_nvim() {
    # install nvim 0.6
    echo "Installing nvim"
    curl -L https://github.com/neovim/neovim/releases/download/v0.6.0/nvim.appimage > nvim.appimage
    chmod +x nvim.appimage
    ./nvim.appimage --appimage-extract
    sudo -s mv squashfs-root /
    sudo -s ln -s /squashfs-root/AppRun /usr/bin/nvim
    rm nvim.appimage
    npm install -g neovim
}

install_nvim_others() {
    # install ripgrep
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
    dpkg -i ripgrep_13.0.0_amd64.deb

    # install fd-menu
    sudo -s apt install fd-find
}

clean() {
    # remove nvim if exists
    if [ -z "$(which nvim)" ]; then
        echo "Removing nvim"
        rm -f $(which nvim)
    fi

    # if .zshrc exists, delete in
    if [ -f $HOME/.zshrc ]; then
        echo "Removing .zshrc"
        rm $HOME/.zshrc
    fi
    # if .gitconfig exists, delete it
    if [ -f $HOME/.gitconfig ]; then
        echo "Removing .gitconfig"
        rm $HOME/.gitconfig
    fi
    # if .config git not exists, create it
    if [ ! -d $HOME/.config/git ]; then
        echo "Creating .config/git"
        mkdir -p $HOME/.config/git
    fi
    # if .config nvim not exists, create it
    if [ ! -d $HOME/.config/nvim ]; then
        echo "Creating .config/nvim"
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
            install_oh_my_zsh
            exit 0
            ;;
        -u|--install2)
            install_oh_my_zsh_plugins
            install_nvm_node
            exit 0
            ;;
        -s|--stow)
            clean
            stow
            exit 0
            ;;
        -o|--others)
            install_nvm_2
            install_nvim
            install_nvim_others
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

