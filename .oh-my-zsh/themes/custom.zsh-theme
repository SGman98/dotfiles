PROMPT='%{$fg_bold[white]%}['
PROMPT+='%F{#55CBCD}%c/'
PROMPT+='%{$reset_color%}$(git_prompt_info)$(git_prompt_status)'
PROMPT+='%{$fg_bold[white]%}]'
PROMPT+='%(?:%{$fg_bold[white]%}~ :%{$fg_bold[red]%}~ )%{$reset_color%}'
RPROMPT='%F{#DDDDFF}@%n'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}, %F{#B7BF5E}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%}✱"
