# Prefer the systemd user agent (ssh-agent.socket, shipped with openssh).
# Keys are added on first use via `AddKeysToAgent yes` in ~/.ssh/config.
# Machines without systemd fall back to one agent per login.
# Old versions of this file exported the agent as universal variables.
set -qU SSH_AUTH_SOCK; and set -eU SSH_AUTH_SOCK SSH_AGENT_PID

# On systemd hosts the socket may not exist yet when the first login shell
# starts (WSL boots both in the same second), so check for systemd itself.
if set -q XDG_RUNTIME_DIR; and test -d /run/systemd/system
    set -gx SSH_AUTH_SOCK (string trim -r -c / -- $XDG_RUNTIME_DIR)/ssh-agent.socket
else if status is-interactive; and not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c) >/dev/null
end
