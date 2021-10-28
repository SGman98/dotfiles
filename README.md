# Testing my dotfiles

sudo apt-get update

sudo apt-get upgrade

## Setting repo
git clone --bare https://github.com/SGman98/dotfiles.git $HOME/dotfiles

git --git-dir=$HOME/dotfiles --work-tree=$HOME checkout

## Install zsh & ohmyzsh
sudo apt-get install zsh

zsh

sudo apt-get install curl

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install zsh plugins
git clone https://github.com/bobthecow/git-flow-completion ~/.oh-my-zsh/custom/plugins/git-flow-completion

git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting


open vim so Plug and all plugins start installing
## Install YCM for vim
cd ~/.config/vim/Plugged/YouCompleteMe/

python3 install.py --all
- if it doesn't work then

git submodule update --init --recursive
- and run the first command again
