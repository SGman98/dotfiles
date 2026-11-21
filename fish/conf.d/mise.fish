if command -v mise &>/dev/null
    set -gx MISE_NODE_DEFAULT_PACKAGES_FILE $XDG_CONFIG_HOME/mise/default-packages/node

    mise activate fish | source
end
