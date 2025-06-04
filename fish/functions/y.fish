# Extents and aliases Yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    set sel (mktemp -t "yazi-sel.XXXXXX")

    yazi $argv --cwd-file="$tmp" --chooser-file="$sel"

    # First if, enables pressing "enter" to open the selected file or directory
    # Second if, enables pressing "q" to quit yazi open dir or "Q" to quit yazi
    if set selection (command cat -- "$sel"); and [ -n "$selection" ]
        echo "" \
        && set_color blue \
        && echo "(yazi) Exited with: " \
        && set_color normal \
        && echo (basename "$selection") \
        && echo "" \
        && z (dirname "$selection")
    else if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        z $cwd
    else
        echo "(y) Exited Yazi with invalid state (probably via ^C)."
    end

    rm -f -- "$tmp" "$sel"
end
