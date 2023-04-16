if command -v tmux &>/dev/null
    abbr -a mux tmuxinator

    if status is-interactive; and not set -q TMUX
        exec tmux -u new-session -A -D -t base
    end
end
