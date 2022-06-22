# My dotfiles

## Package Instalation

```sh
sudo apt update && sudo apt upgrade
```

```sh
sudo apt install stow build-essential cmake curl zsh bat tree neofetch
sudo apt install pandoc texlive-full texlive-latex-extra
sudo apt install python3.8-dev python3-pip python3.8-venv
```

## Install Oh-my-zsh

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```sh
git clone https://github.com/bobthecow/git-flow-completion $ZSH/custom/plugins/git-flow-completion
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode
```

## Install nvm, node and yarn

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node
npm i -g yarn
```

## Install neovim

```sh
curl -L https://github.com/neovim/neovim/releases/download/v0.7.0/nvim.appimage > nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract && rm nvim.appimage
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
```

### neovim extras

```sh
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb
sudo apt install fd-find
```

### Config with LunarVim

```sh
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

## Install config

```sh
stow -v lvim git zsh
```
