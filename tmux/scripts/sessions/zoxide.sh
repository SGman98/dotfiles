#!/usr/bin/env bash

get_zoxide_results() {
	if command -v fish &>/dev/null; then
		fish -c "z --list | awk '{print \$2}'"
	elif command -v zoxide &>/dev/null; then
		zoxide query -l
	else
		echo "zoxide not found"
		exit 1
	fi
}

ZOXIDE_RESULT=$(get_zoxide_results)

PROJECTS=()

while IFS= read -r line; do
	if [ -d "$line/.git" ]; then
		PROJECTS+=("$line")
	fi
done <<<"$ZOXIDE_RESULT"

project=$(printf "%s\n" "${PROJECTS[@]}" | fzf)

if [ -z "$project" ]; then
	exit 1
fi

if command -v tmux &>/dev/null; then
	cd "$project" || exit 1
	dir_path="${PWD/#$HOME\/}"
	SESSION_NAME=$(echo "$dir_path" | tr '/' '-' | sed 's/\.//g')
	if ! command -v tmux &>/dev/null; then
		echo "tmux is not installed"
		exit 1
	fi

	if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
		tmux new-session -d -s "$SESSION_NAME"
		tmux run "tmux-use"
	fi

	if [ -n "$TMUX" ]; then
		tmux switch-client -t "$SESSION_NAME"
	else
		tmux attach-session -t "$SESSION_NAME"
	fi
	exit 0
fi
