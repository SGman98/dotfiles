#!/usr/bin/env bash

# shellcheck source=../functions.sh
source "$HOME/.dotfiles/functions.sh"

PROMPT="::wsl-BOOTSTRAP::"

# WSL appends the whole Windows PATH (~16 dirs on /mnt/c). Every command
# lookup then scans them over the slow 9p bridge: fish startup went from
# ~130ms to ~600ms and mise's hook-env added ~250ms to every prompt.
# Instead, turn that off and link only the Windows tools used from Linux.
LINK_DIR="$HOME/.local/bin"
WIN_SYS="/mnt/c/WINDOWS"

win_tools() {
	local appdata
	appdata=$(wslpath "$("$WIN_SYS/system32/cmd.exe" /c 'echo %LOCALAPPDATA%' 2>/dev/null | tr -d '\r')") ||
		abort "Failed to find the Windows LOCALAPPDATA folder"

	# <link name> <target>
	echo "code $appdata/Programs/Microsoft VS Code/bin/code"
	echo "explorer.exe $WIN_SYS/explorer.exe"
	echo "clip.exe $WIN_SYS/system32/clip.exe"
	echo "rundll32.exe $WIN_SYS/system32/rundll32.exe"
	echo "wsl.exe $WIN_SYS/system32/wsl.exe"
	echo "winget.exe $appdata/Microsoft/WindowsApps/winget.exe"
}

case "$1" in
	setup)
		grep -qi microsoft /proc/version || {
			info "Not running on WSL, skipping"
			exit 0
		}
		confirm "Do you want to setup WSL?" "Y" || abort "Aborting..."

		mkdir -p "$LINK_DIR"
		while read -r name target; do
			if [[ -e $target ]]; then
				ln -sfn "$target" "$LINK_DIR/$name" && success "Linked $name"
			else
				warn "Skipping $name: $target not found"
			fi
		done < <(win_tools)

		if ! grep -qs "^appendWindowsPath *= *false" /etc/wsl.conf; then
			info "Disabling the Windows PATH in /etc/wsl.conf"
			printf '\n[interop]\nappendWindowsPath = false\n' | sudo tee -a /etc/wsl.conf >/dev/null ||
				abort "Failed to update /etc/wsl.conf"
			important "Restart WSL to apply it: wsl.exe --shutdown"
		fi

		success "Setup correctly"
		;;
	remove)
		while read -r name _; do
			[[ -L $LINK_DIR/$name ]] && rm "$LINK_DIR/$name"
		done < <(win_tools)
		info "Remove appendWindowsPath from /etc/wsl.conf by hand if needed"
		success "Removed correctly"
		;;
	*) abort "Usage: $0 {setup|remove}" ;;
esac
