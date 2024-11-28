#!/bin/env bash

LOG_FILE="${LOG_FILE:-/tmp/dotfiles.log}"

log::ansi() {
	local color=37 mod
	case "$@" in
	*reset*) printf "\e[0m" && return ;;
	*black*) color=30 ;;
	*red*) color=31 ;;
	*green*) color=32 ;;
	*yellow*) color=33 ;;
	*blue*) color=34 ;;
	*magenta*) color=35 ;;
	*cyan*) color=36 ;;
	*white*) color=37 ;;
	esac
	case "$@" in
	*regular*) mod=0 ;;
	*bold*) mod=1 ;;
	*dim*) mod=2 ;;
	*italic*) mod=3 ;;
	*underline*) mod=4 ;;
	*blinkslow*) mod=5 ;;
	*blinkfast*) mod=6 ;;
	*blink*) mod=5 ;;
	*invert*) mod=7 ;;
	*hidden*) mod=8 ;;
	*strikethrough*) mod=9 ;;
	esac
	case "$@" in
	*bg*) color=$((color + 10)) ;;
	esac

	printf "\e[%sm" "${mod:+"$mod;"}${color}"
}

log() {
	local level="INFO" scope file=false message level_color reset timestamp

	OPTIND=1
	while getopts "l:f" opt; do
		case $opt in
		l) level=$OPTARG ;;
		f) file=true ;;
		*) log::abort "Usage: log [-l level] message" ;;
		esac
	done
	shift $((OPTIND - 1))

	message="$*"
	timestamp="$(date +"%Y-%m-%d %H:%M:%S")"

	declare -A level_colors=(
		["IMPORTANT"]="$(log::ansi magenta)"
		["INFO"]="$(log::ansi blue)"
		["WARN"]="$(log::ansi yellow)"

		["ABORT"]="$(log::ansi red)"
		["ERROR"]="$(log::ansi red)"
		["SUCCESS"]="$(log::ansi green)"
		["OK"]="$(log::ansi green)"

		["ASK"]="$(log::ansi cyan)"
		["CONFIRM"]="$(log::ansi yellow)"
	)

	reset="$(log::ansi reset)"

	scopes=()
	ignored_scopes=("main" "log")
	for ((i = ${#FUNCNAME[@]} - 1; i > 0; i--)); do
		IFS="::" read -r -a parts <<<"${FUNCNAME[$i]}"
		if [[ ! ${ignored_scopes[*]} =~ ${parts[0]} ]]; then
			scopes+=("${parts[0]}")
		fi
	done

	scopes_str=$(
		IFS="::"
		echo "${scopes[*]}"
	)

	scope="${SCOPE:+$SCOPE::}${scopes_str:+$scopes_str::}$level"
	scope=$(echo "$scope" | tr '[:lower:]' '[:upper:]')

	level_color="${level_colors["$level"]}"

	printf "%s [%s] %s\n" "$timestamp" "$level_color$scope$reset" "$message"

	if [ "$file" = true ]; then
		printf "%s [%s] %s\n" "$timestamp" "$scope" "$message" >>"$LOG_FILE"
	fi
}

log::important() { log -l "IMPORTANT" "$@"; }
log::info() { log -l "INFO" "$@"; }
log::warn() { log -l "WARN" "$@"; }

log::abort() { log -l "ABORT" "$@" && exit 1; }
log::error() { log -l "ERROR" "$@"; }
log::success() { log -fl "SUCCESS" "$@"; }
log::ok() { log -l "OK" "$@"; }

log::ask() {
	local prompt optional=false is_path=false response

	OPTIND=1
	while getopts "p:xe" opt; do
		case $opt in
		p) prompt=$OPTARG ;;
		x) optional=true ;;
		e) is_path=true ;;
		*) log::abort "Usage: log::ask [-p prompt] [-x] [-e] var" ;;
		esac
	done
	shift $((OPTIND - 1))

	[[ -z $prompt ]] && log::abort "Prompt cannot be empty"

	while true; do
		if [[ $is_path == "true" ]]; then
			read -rep "$(log -l "ASK" "$prompt") " response
		else
			read -rp "$(log -l "ASK" "$prompt") " response
		fi
		[[ -z $response && $optional == "true" ]] && break
		[[ -n $response ]] && break
		log::warn "Response cannot be empty"
	done

	local -n __resultvar="${!#}"
	__resultvar="$response"
}

log::confirm() {
	local prompt="$1" default="Y" yn="[Y/n]" response
	[[ $2 =~ ^[Nn]$ ]] && default="N" && yn="[y/N]"
	read -rp "$(log -l "CONFIRM" "$prompt") $yn " response
	[[ -z $response ]] && response=$default
	case "$response" in
	[Yy][Ee][Ss] | [Yy]) true ;;
	[Nn][Oo] | [Nn]) false ;;
	*) echo "Invalid input" && exit 1 ;;
	esac
}
