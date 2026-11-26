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
Linux (`code`, `explorer.exe`, `clip.exe`, `rundll32.exe`, `wsl.exe`, `winget.exe`) into
`~/.local/bin`. Restart WSL afterwards:

```sh
wsl.exe --shutdown
```

### Neovim

Open neovim to start installing the plugins

### Claude Code

`claude/manage.sh` installs Claude Code and the sandbox dependencies
(bubblewrap, socat), links `CLAUDE.md`, `settings.json` and `statusline.sh` into
`~/.claude`, and installs the plugins declared in `settings.json`. Everything
else in `~/.claude` (login, history, memory, plugin cache) stays local. Then
run `claude`, log in, and check the setup with `/sandbox` and `/doctor`.

Claude Code rewrites `settings.json` (plugin installs, `/config`) in its own
JSON layout, so keep that layout; `.prettierignore` stops Neovim reformatting it.

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

The repo's `mise.toml` runs the tools Neovim's Mason installs (shellcheck,
shfmt, stylua, taplo, lua-language-server; fish_indent ships with fish), so
open nvim once first:

```sh
mise run lint     # check everything (includes lint:lua)
mise run lint:lua # type-check the Neovim config, as lua_ls sees it in the editor
mise run fmt      # format everything
```

`lint:lua` reads the installed plugins for their types, so run `:Lazy sync`
first on a new machine.

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
- [ ] Try Astral's `ty` in place of basedpyright once it reaches 1.0
      (`nvim/lua/config/languages.lua`).
