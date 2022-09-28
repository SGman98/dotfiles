# ---- PreInstall ----
export ZVM_INIT_MODE=sourcing # zsh-vim-mode prevent binding conflicts

# ---- Plugins ----
plugins=(
    # ZSH
    MichaelAquilina/zsh-autoswitch-virtualenv
    jeffreytse/zsh-vi-mode
    zdharma-continuum/fast-syntax-highlighting
    # Git
    petervanderdoes/git-flow-completion
    # Completions
    MenkeTechnologies/zsh-cargo-completion
    lukechilds/zsh-nvm
)


# ---- Plugin Installation ----
function install_plugins() {
    # read all arguments into an array
    local plugins=("$@")
    for plugin in "${plugins[@]}"; do
        local url="https://github.com/$plugin"
        local plugin_name="${plugin##*/}"
        local dir="$XDG_DATA_HOME/zsh/plugins/$plugin_name"
        if [ ! -d "$dir" ]; then
            # clone silently
            echo "Installing $plugin_name..."
            git clone --quiet "$url" "$dir"
        fi

        # source plugin the file that ends with .plugin.zsh
        for file in "$dir"/*.plugin.zsh; do
            if [ -f "$file" ]; then
                source "$file"
            fi
        done
    done
}

# ---- Plugin Cleanup ----
function clean_plugins() {
    # read all files in the plugins directory and compare with $@
    # if the plugin is not in $@, remove it
    local plugins_dir="$XDG_DATA_HOME/zsh/plugins"
    local plugins=("$@")

    # plugins are like "MichaelAquilina/zsh-autoswitch-virtualenv"
    # we need to convert them to "zsh-autoswitch-virtualenv"

    for plugin in "$plugins_dir"/*; do
        local plugin_name="${plugin##*/}"
        # use grep to check if the plugin is in $@
        if ! echo "${plugins[*]}" | grep -q "$plugin_name"; then
            echo "Removing $plugin_name ..."
            rm -rf "$plugin"
        fi
    done
}


# ---- call functions ----
install_plugins "${plugins[@]}"
clean_plugins "${plugins[@]}"


unfunction install_plugins
unfunction clean_plugins