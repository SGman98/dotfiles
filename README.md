# My dotfiles

> Currently using [ArchWSL](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)

> Set XDG Base Directory if not set using a /etc/profile.d [script](https://github.com/Conaclos/profile.d/blob/master/10-xdg-base-dirs.sh)

## Package Instalation

```sh
sudo pacman -Syyu
```

```sh
sudo pacman -S
  # Base
  base-devel
  # shell
  zsh starship
  # utils
  git openssh wget
  # dotfiles management
  stow
```

## Install aur helper

```sh
git clone https://aur.archlinux.org/yay.git /opt/yay
sudo chown -R $USER:$USER /opt/yay
cd /opt/yay
makepkg -si
```

## ZSH

### Set ZSH as default shell

```sh
chsh -s /bin/zsh
```

### Set ZDOTDIR to XDG Base Directory

```sh
echo "ZDOTDIR=$XDG_CONFIG_HOME/zsh" | sudo tee -a /etc/zsh/zshenv
```

## SSH and GPG

- Generate SSH key [Github SSH](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

- Generate GPG key [Github GPG](https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/generating-a-new-gpg-key)

> Or import existing key from a file

```
gpg --import <key-file>
```

## Clone dotfiles

```sh
git clone git@github.com:SGman98/.dotfiles.git $HOME/.dotfiles
stow -v -d $HOME/.dotfiles/ -t $XDG_CONFIG_HOME/ -S git zsh
```

## Install Languages

### Python

```sh
sudo pacman -S python python-pip tk
```

### Rust

```sh
sudo pacman -S rustup
rustup default stable
```

### Node

```sh
yay -S nvm
nvm install --lts
npm install -g yarn
```

## Extras

### Pacman

```sh
sudo pacman -S
  bat
  exa
  fd
  fzf
  htop
  neofetch
  neovim
  ripgrep
  thefuck
  tmux
  tree
```

### Yay

```sh
yay -S
  gitflow-avh
```

> TheFuck in WSL
>
> ```sh
> echo "excluded_search_path_prefixes = ['/mnt/']" | tee -a $XDG_CONFIG_HOME/thefuck/settings.py
> ```
