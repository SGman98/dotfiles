if command -v eza &>/dev/null
    abbr -a ls eza
    abbr -a l "eza -la --group-directories-first"
else
    abbr -a l ls -lAhX
end
