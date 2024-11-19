function lower_case --description "Convert a string to lower case"
    echo $argv | tr '[:upper:]' '[:lower:]'
end

function kebab_case --description "Convert a string to kebab-case"
    echo $argv | sed 's/ /-/g'
end

function title_case --description "Convert a string to Title Case"
    echo $argv | sed 's/\b\(.\)/\u\1/g'
end

function select_theme --description "Select a theme" --argument theme --argument variation
    set theme (lower_case $theme)
    set variation (lower_case $variation)

    # echo "Selecting theme $theme with variation $variation"
    switch $theme
    case "catppuccin"
        set -gx THEME (title_case $theme $variation)
        set -gx BAT_THEME $THEME
        set -gx NVIM_THEME (kebab_case $theme $variation)
    case "*"
        echo "Theme $theme not found"
    end
end
