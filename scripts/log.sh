#!/usr/bin/env bash

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
		*bg*) color="$((color + 10))" ;;
	esac

	printf "\e[%sm" "${mod:+"$mod;"}${color}"
}

log() {
	local -A level_colors=(
		["ABORT"]="$(log::ansi red)"
		["CANCEL"]="$(log::ansi red)"
		["ERROR"]="$(log::ansi red)"
		["WARN"]="$(log::ansi yellow)"

		["IMPORTANT"]="$(log::ansi magenta)"
		["SUCCESS"]="$(log::ansi green)"
		["USAGE"]="$(log::ansi cyan)"
		["INFO"]="$(log::ansi blue)"
		["OK"]="$(log::ansi green)"

		["ASK"]="$(log::ansi cyan)"
		["CONFIRM"]="$(log::ansi yellow)"
	)

	local level="INFO" file=false

	local usage_cmd usage_help usage_options parsed
	usage_cmd="$(basename "$0")"
	usage_cmd="${usage_cmd:+"$usage_cmd run log"}"
	usage_help+="[-f] [-l <level>] [message]\n"
	usage_help+="[-u] [test]"
	usage_options+="-f, --file\t\tLog to file\n"
	usage_options+="-l, --level <level>\tDefault: $level\tAvailable levels: ${!level_colors[*]}"

	parsed="$(getopt -o ful: -l file,level: -n "$usage_cmd" -- "$@")" || log::usage
	eval set -- "$parsed"
	while true; do
		case "$1" in
			-f | --file)
				file=true
				shift
				;;
			-l | --level)
				level="$2"
				[[ ! ${!level_colors[*]} =~ $level ]] && log::usage
				shift 2
				;;
			--)
				shift
				break
				;;
			*) log::usage "Not implemented: $1" ;;
		esac
	done
	local message="$*"

	local level_color scope
	level_color="${level_colors["$level"]}"
	scope="$(log::get_scope)"
	scope="${scope:+"$scope:"}$level"

	local reset underline timestamp
	reset="$(log::ansi reset)"
	underline="$(log::ansi underline)"
	timestamp="$(date +"%Y-%m-%d %H:%M:%S")"

	printf "%s [%s] %s\n" "$underline$timestamp$reset" "$level_color$scope$reset" "$(echo -e "$message")"

	[ "$file" = true ] && printf "%s [%s] %s\n" "$timestamp" "$scope" "$message" >>"$LOG_FILE"
}

log::abort() { log -l "ABORT" "$@" 1>&2 && exit 1; }
log::cancel() { log -l "CANCEL" "$@" 1>&2 && exit 1; }
log::error() { log -l "ERROR" "$@" 1>&2; }
log::warn() { log -l "WARN" "$@" 1>&2; }

log::important() { log -l "IMPORTANT" "$@"; }
log::success() { log -fl "SUCCESS" "$@"; }
log::usage() {
	local usage="" options="" error=""
	if [[ -v usage_cmd ]] && [[ -v usage_help ]]; then
		usage="\n$(log::ansi cyan)Usage:$(log::ansi reset)\n"
		usage_cmd="$(log::ansi underline)$usage_cmd$(log::ansi reset)"
		usage+="$(echo -e "$usage_help" | sed "s/^/\t$usage_cmd /g")"
	fi
	if [[ -v usage_options ]]; then
		options="\n$(log::ansi cyan)Options:$(log::ansi reset)\n"
		options+="$(echo -e "$usage_options" | sed 's/^/\t/g')"
	fi
	if [[ -n $* ]]; then
		error="\n$(log::ansi red)Error:$(log::ansi reset)\n"
		error+="$(echo -e "$*" | sed 's/^/\t/g')"
	fi
	unset usage_cmd usage_help usage_options
	log -l "USAGE" "$usage$options$error" 1>&2 && exit 1
}
log::info() { log -l "INFO" "$@"; }
log::ok() { log -l "OK" "$@"; }

log::ask() {
	local prompt optional=false is_path=false

	local usage_cmd usage_help usage_options parsed
	usage_cmd="$(basename "$0")"
	usage_cmd="${usage_cmd:+"$usage_cmd run log::ask"}"
	usage_help+="[-p <prompt>] [-x] [-e] <var>"
	usage_options+="-p, --prompt <prompt>\tPrompt message\n"
	usage_options+="-x, --optional\tWhether or not the response can be empty\n"
	usage_options+="-e, --path\tWheter or not to add completions for paths"

	parsed="$(getopt -o xep: -l optional,path,prompt: -n "$usage_cmd" -- "$@")" || log::usage
	eval set -- "$parsed"
	while true; do
		case "$1" in
			-x | --optional)
				optional=true
				shift
				;;
			-e | --path)
				is_path=true
				shift
				;;
			-p | --prompt)
				prompt="$2"
				shift 2
				;;
			--)
				shift
				break
				;;
			*) log::usage "Not implemented: $1" ;;
		esac
	done

	[[ ! -v 1 ]] && log::usage "Variable name is required"
	[[ ! -v prompt ]] && log::usage "Prompt cannot be empty"

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
	[[ ! -v 1 ]] && log::usage "Prompt message is required"
	local prompt="$1" default="Y" yn="[Y/n]" response
	[[ -v 2 ]] && [[ $2 =~ ^[Nn][Oo]$ ]] && default="N" && yn="[y/N]"
	[[ -v 2 ]] && [[ $2 =~ ^[Yy][Ee][Ss]$ ]] && default="Y" && yn="[Y/n]"
	read -rp "$(log -l "CONFIRM" "$prompt") $yn " response
	[[ -z $response ]] && response="$default"
	case "$response" in
		[Yy][Ee][Ss] | [Yy]) true ;;
		[Nn][Oo] | [Nn]) false ;;
		*) log::abort "Invalid response: $response" ;;
	esac
}

log::get_scope() {
	local scopes=() ignored_scopes scopes_str parts
	ignored_scopes=("main" "log")
	[[ -n $SCOPE ]] && scopes+=("$SCOPE")
	for ((i = "${#FUNCNAME[@]}" - 1; i > 0; i--)); do
		IFS=":" read -r -a parts <<<"${FUNCNAME["$i"]}"
		if [[ ! ${ignored_scopes[*]} =~ ${parts[0]} ]]; then
			if [[ ${#scopes[@]} -eq 0 ]]; then
				scopes+=("${parts[0]}")
			else
				[[ ${scopes[-1]} != "${parts[0]}" ]] && scopes+=("${parts[0]}")
			fi
		fi
	done

	scopes_str="$(
		IFS=":"
		echo "${scopes[*]}"
	)"

	echo "${scopes_str}" | tr '[:lower:]' '[:upper:]'
}
