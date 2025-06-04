# Pipe-enabled variant of y. Only thing changed is echoing instead of executing something.
function ypipe
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    set sel (mktemp -t "yazi-sel.XXXXXX")

    yazi $argv --cwd-file="$tmp" --chooser-file="$sel"

    if set selection (command cat -- "$sel"); and [ -n "$selection" ]
        echo (dirname $selection)
    else if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        echo $cwd
    else
        echo "(ypipes Exited Yazi with invalid state (probably via ^C)."
    end

    rm -f -- "$tmp" "$sel"
end
