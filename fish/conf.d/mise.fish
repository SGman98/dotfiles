if command -v mise &>/dev/null
    set -gx ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc
    set -gx ASDF_DATA_DIR $XDG_DATA_HOME/asdf

    set -gx MISE_USE_VERSIONS_HOST 0 # tmp fix for version

    mise activate fish | source
    mise completions fish | source
end
