if command -v mise &>/dev/null
    set -gx ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc
    set -gx ASDF_DATA_DIR $XDG_DATA_HOME/asdf

    set -gx MISE_NODE_DEFAULT_PACKAGES_FILE $XDG_CONFIG_HOME/mise/default-packages/node

    mise activate fish | source
end
