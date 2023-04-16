set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/config.toml
set -gx STARSHIP_CACHE $XDG_CACHE_HOME/starship

if command -v starship &>/dev/null
    starship init fish | source
    enable_transience
end
