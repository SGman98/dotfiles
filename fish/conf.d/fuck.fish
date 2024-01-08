if command -v fuck &>/dev/null
    set -l line "excluded_search_path_prefixes = ['/mnt/']"
    if not test -d $XDG_CONFIG_HOME/thefuck
        mkdir $XDG_CONFIG_HOME/thefuck
    end
    if not grep -qF $line $XDG_CONFIG_HOME/thefuck/settings.py
    echo $line | tee -a $XDG_CONFIG_HOME/thefuck/settings.py
end
