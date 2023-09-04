if command -v rtx &>/dev/null
    set -gx ASDF_CONFIG_FILE $XDG_CONFIG_HOME/asdf/asdfrc
    set -gx ASDF_DATA_DIR $XDG_DATA_HOME/asdf

    rtx activate fish | source
    rtx completions fish | source
end
