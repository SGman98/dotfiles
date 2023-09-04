function fish_greeting
    if command -v fortune &>/dev/null; and command -v cowsay &>/dev/null; and command -v lolcat &>/dev/null
        # fortune -sa | cowsay -f(cowsay -l | tail -n +2 | tr ' ' '\n' | sort -R | head -1) -W(math (stty size | cut -d" " -f2) - 3) | lolcat -F 0.01
    end
end
