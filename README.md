# My dotfiles

> Currently using [ArchWSL](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)
> Set XDG Base Directory if not set using a /etc/profile.d [script](https://github.com/Conaclos/profile.d/blob/master/10-xdg-base-dirs.sh)

## Dotfiles Instalation

> For the moment it only works on Arch based distros

```sh
sudo pacman -Syyu
```

```sh
sudo pacman -S base-devel git openssh wget
```

## SSH and GPG

- Generate SSH key [Github SSH](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

- Generate GPG key [Github GPG](https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification/generating-a-new-gpg-key)

> Or import existing gpg key from a file

```sh
gpg --import <key-file>
```

## Bootstrap dotfiles

Clone the repo

```sh
git clone https://github.com/SGman98/dotfiles.git $HOME/.dotfiles
```

Then run then bootstrap.sh script

### Neovim

Open neovim to start installing the plugins

### Tmux & Tmux Plugin Manager

Within tmux, press `prefix + I` to install the plugins

### Fish plugins

```sh
curl -sL https://git.io/fisher | source && fisher update
```

## Install Languages

### Node

```sh
nvm install lts
```

### Python

```sh
sudo pacman -S python python-pip tk
```

### Rust

```sh
sudo pacman -S rustup
rustup default stable
```
