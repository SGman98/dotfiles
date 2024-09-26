#!/usr/bin/env bash

parent_path=$(
	cd "$(dirname "${BASH_SOURCE[0]}")"
	pwd -P
)
echo $parent_path

elements=$(cat $parent_path/gitmoji-list.txt)

selected=$(echo "$elements" | fzf --delimiter '\t')

if [ -n "$selected" ]; then
	element=$(echo "$selected" | awk '{print $1}')
	tmux send-keys -t "$TMUX_PANE" "$element"
fi
