function zfzf
    if test $PWD = $HOME
        # if in HOME, enter yazi first
        set -l dir (ypipe)
        cd $dir && fzf | read -l result \
        && echo "" \
        && set_color blue \
        && echo "(zfzf) Exited with: " \
        && set_color normal \
        && echo (basename "$result") \
        && echo "" \
        && z (dirname "$PWD/$result")
    else
        fzf | read -l result \
        && echo "" \
        && set_color blue \
        && echo "(zfzf) Exited with: " \
        && set_color normal \
        && echo (basename "$result") \
        && echo "" \
        && z (dirname "$PWD/$result")
    end
end
