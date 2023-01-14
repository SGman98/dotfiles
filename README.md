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

```
gpg --import <key-file>
```

## Bootstrap dotfiles

```sh
bash <(curl -s https://raw.githubusercontent.com/SGman98/.dotfiles/main/bootstrap.sh)
```

### Neovim

Open neovim to start installing the plugins

### Tmux & Tmux Plugin Manager

> Within tmux, press `prefix + I` to install the plugins

### TheFuck in WSL

```sh
echo "excluded_search_path_prefixes = ['/mnt/']" | tee -a $XDG_CONFIG_HOME/thefuck/settings.py
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
