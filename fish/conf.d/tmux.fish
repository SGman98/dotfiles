if command -v tmux &>/dev/null
    # Skip non-terminal logins: on WSL+systemd cold boot a hidden `login` shell
    # (TERM=dumb, no Windows PATH/WSL_INTEROP) would otherwise start the server
    # and seed every session with its stripped environment.
    if status is-interactive; and not set -q TMUX; and test "$TERM" != dumb
        tmux -u new-session -A -s base
    end
end
