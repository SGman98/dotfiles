#!/usr/bin/env bash

utils::ansi_grid() {
	local colors=("black" "red" "green" "yellow" "blue" "magenta" "cyan" "white")
	local modifiers=("regular" "bold" "dim" "italic" "underline" "blinkslow" "blinkfast" "invert" "hidden" "strikethrough")

	local max_color_length=0 max_mod_length=0

	for color in "${colors[@]}"; do
		[[ ${#color} -gt $max_color_length ]] && max_color_length=$((${#color} + 1))
	done
	for mod in "${modifiers[@]}"; do
		[[ ${#mod} -gt $max_mod_length ]] && max_mod_length=$((${#mod} + 1))
	done

	printf "%-*s" $max_mod_length "Mod/Color"
	for color in "${colors[@]}"; do
		printf "%-*s" $max_color_length "$color"
	done
	printf "\n"

	for mod in "${modifiers[@]}"; do
		printf "%-*s" $max_mod_length "$mod"
		for color in "${colors[@]}"; do
			local code code_bg reset_code code_length code_bg_length reset_length padding
			code=$(log::ansi "$color$mod")
			code_bg=$(log::ansi "bg$color$mod")
			reset_code=$(log::ansi reset)
			code_length=$(echo -e "$code" | wc -c)
			code_bg_length=$(echo -e "$code_bg" | wc -c)
			reset_length=$(echo -e "$reset_code" | wc -c)
			padding=$((max_color_length + code_length + code_bg_length + reset_length + 1))
			printf "%-*s" $padding "$code ■ $code_bg ■ $reset_code"
		done
		printf "\n"
	done
}
