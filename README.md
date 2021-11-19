# Testing my dotfiles

`sudo apt-get update`

`sudo apt-get upgrade`

`sudo apt-get install python3.8-dev build-essential cmake curl`

## Install zsh & ohmyzsh
`sudo apt-get install zsh`

`zsh`

`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

## Install zsh plugins
`git clone https://github.com/bobthecow/git-flow-completion $ZSH/custom/plugins/git-flow-completion`

`git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting`

`git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode`

## Setting repo
`git clone --bare https://github.com/SGman98/dotfiles.git $HOME/dotfiles`

`git --git-dir=$HOME/dotfiles --work-tree=$HOME checkout`

`dot config --local status.showUntrackedFiles no`

`dot update-index --assume-unchanged ~/.gitconfig`

> Config repo for updates\
> Config user, email, signingkey (gpg)\
> `dot fetch`\
> `dot push --set-upstream origin master`

## Vim

open vim so Plug and all plugins start installing

#### Install YCM for vim
&nbsp;&nbsp;`cd ~/.config/vim/plugged/youcompleteme/`

&nbsp;&nbsp;`python3 install.py --all`

> if it doesn't work then\
> `git submodule update --init --recursive`\
> and run the first command again

## Extras

#### nodejs

&nbsp;&nbsp;`sudo apt install nodejs npm`

#### reveal-md

&nbsp;&nbsp;`npm install -g reveal-md`

#### wsl setup xserver

&nbsp;&nbsp;Follow this [file](https://github.com/davidbombal/wsl2/blob/main/ubuntu_gui_youtube)

#### pandoc

`sudo apt install pandoc pandoc-citeproc texlive-full texlive-latex-extra`

#### terminal utils

`sudo apt install bat tree neofetch`

