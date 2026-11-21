# My dotfiles

> Currently using [ArchWSL](https://wsldl-pg.github.io/ArchW-docs/How-to-Setup/)
> Set XDG Base Directory if not set using a /etc/profile.d [script](https://github.com/Conaclos/profile.d/blob/master/10-xdg-base-dirs.sh)

## Dotfiles Installation

> For the moment it only works on Arch based distros

```sh
sudo pacman -Syyu
```

```sh
sudo pacman -S base-devel git openssh wget
```

## Bootstrap dotfiles

Clone the repo

```sh
git clone https://github.com/SGman98/dotfiles.git $HOME/.dotfiles
```

Then run the `bootstrap.sh` script. It installs the packages in `packages.sh`
and runs `<module>/manage.sh setup` for every module, asking before each one.

### WSL

`wsl/manage.sh` turns off `appendWindowsPath` in `/etc/wsl.conf`, which keeps
the slow `/mnt/c` dirs out of `PATH`. It links only the Windows tools used from
Linux (`code`, `explorer.exe`, `clip.exe`, `wsl.exe`, `winget.exe`) into
`~/.local/bin`. Restart WSL afterwards:

```sh
wsl.exe --shutdown
```

### Neovim

Open neovim to start installing the plugins

### Tmux & Tmux Plugin Manager

Within tmux, press `prefix + I` to install the plugins

### Fish plugins

```sh
curl -sL https://git.io/fisher | source && fisher update
```

## Install Languages

Node, Python (uv), Java and Maven are managed by mise (`mise/config.toml`):

```sh
mise install
```

### Rust

```sh
sudo pacman -S rustup
rustup default stable
```

## Lint & format

The repo's `mise.toml` pins shellcheck, shfmt, stylua and taplo (fish_indent
ships with fish):

```sh
mise install
mise run lint # check everything
mise run fmt  # format everything
```

## Deprecated

These configs are kept for reference but are no longer maintained. They need
attention before using them again.

- `zsh/`: replaced by fish.
- `alacritty/`: unused on WSL. The `.yml` config format was dropped in
  alacritty 0.13 and must be migrated to `.toml`.

The bootstrap script still offers to set them up.

## TODO

- [ ] Bootstrap: skip deprecated modules, and treat declining a module as a
      skip instead of a failure.
- [ ] Create the `docker` group (removed from `fish/conf.d/docker.fish`).
- [ ] The unfinished `bin/dot` + `scripts/` rewrite lives on the
      `bootstrap-rewrite` branch.
