PROMPT='%{$fg[green]%}%c/%{$reset_color%}$(git_prompt_info)$(git_prompt_status)'
PROMPT+='
%(?:%{$fg_bold[white]%}$ :%{$fg_bold[red]%}$ )%{$reset_color%}'
RPROMPT='%{$fg[gray]%}@%n'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}on git:(%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[white]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[white]%})"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}✱"
