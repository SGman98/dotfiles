#!/bin/bash

IFS=$'\t' read -r model dir pct < <(
	jq -r '[.model.display_name, .workspace.current_dir, (.context_window.used_percentage // 0 | floor)] | @tsv'
)
branch=$(git -C "$dir" branch --show-current 2>/dev/null)

echo "[$model] ${dir##*/}${branch:+ ($branch)} | ${pct}% context"
