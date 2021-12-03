#!/usr/bin/env zsh
function install_packages() {
    # install zsh
    sudo apt update && sudo apt upgrade
    sudo apt install stow build-essential cmake curl python3.8-dev zsh pandoc texlive-full texlive-latex-extra bat tree neofetch
    zsh
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # install plugins
    git clone https://github.com/bobthecow/git-flow-completion $ZSH/custom/plugins/git-flow-completion
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting
    git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode

    # install nvm and node
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    nvm install node

    # install nvim 0.6
    curl -L https://github.com/neovim/neovim/releases/download/v0.6.0/nvim.appimage > nvim.appimage
    chmod +x nvim.appimage
    ./nvim.appimage --appimage-extract

    # install ripgrep
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
    sudo dpkg -i ripgrep_13.0.0_amd64.deb

    # install fd-menu
    sudo apt install fd-find
}
install_packages

if [ -z $STOW_FOLDERS ]; then
    STOW_FOLDERS="git nvim zsh"
fi

if [ -z $DOTFILES ]; then
    DOTFILES=$HOME/.dotfiles
fi

for folder in $(echo $STOW_FOLDERS)
do
    stow -v $folder
done
