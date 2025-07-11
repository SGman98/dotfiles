if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings

abbr -a c clear

# ---- Pacman ----
abbr -a pac sudo pacman

# ---- Systemctl ----
abbr -a sc sudo systemctl
abbr -a scss sudo systemctl start
abbr -a scst sudo systemctl stop

# ---- Default editors ----
set -gx EDITOR nvim
set -gx VISUAL nvim

abbr -a e $EDITOR
abbr -a v $EDITOR
abbr -a vim $EDITOR
abbr -a vs nvim -S

# ---- GPG ----
set -x GPG_TTY (tty)

# if test (uname -r | grep -i microsoft) != ""
#     set -x BROWSER wsl-open
# end

fish_add_path -m /usr/local/bin /usr/bin /bin
fish_add_path -m $HOME/.dotfiles/bin
