#!/usr/bin/env bash

# shellcheck source=../functions.sh
source "$HOME/.dotfiles/functions.sh"

PROMPT="::claude-BOOTSTRAP::"
CLAUDE_DIR=$HOME/.claude
SETTINGS=$HOME/.dotfiles/claude/settings.json

# One at a time: each `claude plugin` call rewrites settings.json
install_plugins() {
	local repo plugin
	for repo in $(jq -r '.extraKnownMarketplaces // {} | .[].source | select(.source == "github") | .repo' "$SETTINGS"); do
		claude plugin marketplace add "$repo" --scope user >/dev/null || warn "Failed to add marketplace $repo"
	done
	for plugin in $(jq -r '.enabledPlugins // {} | to_entries[] | select(.value) | .key' "$SETTINGS"); do
		claude plugin install "$plugin" --scope user >/dev/null || warn "Failed to install plugin $plugin"
	done
}

case "$1" in
	setup)
		confirm "Do you want to setup claude?" "Y" || abort "Aborting..."
		if ! command -v claude &>/dev/null; then
			info "Installing Claude Code"
			curl -fsSL https://claude.ai/install.sh | bash || abort "Failed to install Claude Code"
			export PATH="$HOME/.local/bin:$PATH"
		fi
		install_package "jq" || abort "Failed to install jq"
		# Sandbox dependencies (Linux/WSL2)
		install_package "bubblewrap" || abort "Failed to install bubblewrap"
		install_package "socat" || abort "Failed to install socat"

		check_path_link "$CLAUDE_DIR/CLAUDE.md" "$HOME/.dotfiles/claude/CLAUDE.md" || abort "Failed to link $CLAUDE_DIR/CLAUDE.md"
		check_path_link "$CLAUDE_DIR/settings.json" "$SETTINGS" || abort "Failed to link $CLAUDE_DIR/settings.json"
		check_path_link "$CLAUDE_DIR/statusline.sh" "$HOME/.dotfiles/claude/statusline.sh" || abort "Failed to link $CLAUDE_DIR/statusline.sh"

		install_plugins
		success "Setup correctly"
		;;
	remove)
		for file in CLAUDE.md settings.json statusline.sh; do
			if [[ -L $CLAUDE_DIR/$file ]]; then
				rm "$CLAUDE_DIR/$file" || abort "Failed to remove $CLAUDE_DIR/$file"
			fi
		done
		success "Removed correctly"
		;;
	*) abort "Usage: $0 {setup|remove}" ;;
esac
