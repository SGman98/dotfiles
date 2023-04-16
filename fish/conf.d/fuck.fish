if command -v fuck &>/dev/null
    set -l line "excluded_search_path_prefixes = ['/mnt/']"
    if not grep -qF $line $XDG_CONFIG_HOME/thefuck/settings.py
    echo $line | tee -a $XDG_CONFIG_HOME/thefuck/settings.py
    end
end
