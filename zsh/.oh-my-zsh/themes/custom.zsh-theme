username() {
    echo "%{$fg_bold[blue]%}%n@$(hostname)"
}
directory() {
    echo "%{$fg_bold[white]%}%(5~|%-1~/…/%2~|%4~)"
}
venv() {
    echo "${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}"
}

PROMPT='%{$fg_bold[cyan]%} ┌──$(venv)($(username)%{$fg_bold[cyan]%})─[$(directory)%{$fg_bold[cyan]%}]$(git_prompt_info)$(git_prompt_status)%{$reset_color%}
'

PROMPT+='%{$fg_bold[cyan]%} └─%(?.%{$fg_bold[white]%}$ .%{$fg_bold[red]%}$ )%{$reset_color%}'

RPROMPT=''

# set the git_prompt_info text
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}─(%F{#B7BF5E}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[cyan]%})%{$reset_color%}"

# set the git_prompt_status text
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%} ✱"

