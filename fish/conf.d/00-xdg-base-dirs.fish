# Only fill in what the system left unset, so values exported by the OS
# (flatpak, WSLg, desktop sessions) are kept.
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME $HOME/.cache
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME $HOME/.local/state

set -q XDG_CONFIG_DIRS; or set -gx --path XDG_CONFIG_DIRS /etc/xdg
set -q XDG_DATA_DIRS; or set -gx --path XDG_DATA_DIRS /usr/local/share /usr/share
