if command -v tmux &>/dev/null
    if status is-interactive; and not set -q TMUX
        exec tmux -u new-session -A -D -t base
    end
end
