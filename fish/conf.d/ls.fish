if command -v exa &>/dev/null
    abbr -a ls exa
    abbr -a l "exa -la"
else
    abbr -a l ls -lAhX
end
