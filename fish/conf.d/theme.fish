# Catppuccin Mocha everywhere. The terminal (Windows Terminal) sets the 16 ANSI
# colors, which starship, fzf, eza, etc. follow. Tools with their own palette
# are set to Mocha directly: nvim (plugins/theme.lua), tmux (tmux.conf), and
# bat/delta and fish below.

set -gx BAT_THEME "Catppuccin Mocha"
fish_config theme choose catppuccin-mocha
