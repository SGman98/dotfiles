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

fish_add_path -m $HOME/.local/bin
fish_add_path -m $HOME/.dotfiles/bin

if status is-interactive
    fish_vi_key_bindings

    # ---- GPG ----
    set -gx GPG_TTY (tty)

    # ---- Zoxide ----
    if command -v zoxide &>/dev/null
        zoxide init fish | source
    end
end
