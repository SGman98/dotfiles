# My dotfiles

## Package Instalation

```sh
sudo apt update && sudo apt upgrade
```

```sh
sudo apt install stow build-essential cmake curl python3.8-dev zsh pandoc texlive-full texlive-latex-extra bat tree neofetch fd-find
```

## Install Oh-my-zsh

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```sh
git clone https://github.com/bobthecow/git-flow-completion $ZSH/custom/plugins/git-flow-completion\
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting\
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode
```

## Install neovim

```sh
curl -L https://github.com/neovim/neovim/releases/download/v0.6.1/nvim.appimage > nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract && rm nvim.appimage
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
```

### neovim extras

```sh
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
dpkg -i ripgrep_13.0.0_amd64.deb
```

### Config with AstroVim

```sh
git clone https://github.com/kabinspace/AstroVim ~/.config/nvim
nvim +PackerSync
```

## Install nvm, node and yarn

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node
npm i -g yarn
```

## Install config

```sh
stow nvim git zsh
```
