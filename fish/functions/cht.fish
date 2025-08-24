function cht
    echo " ╔══════════RECENTS═════════╗"
            zoxide query -l -s | \
            head -n 5 | \
            sed "s|/Users/kai-admin|~|g" | \
            awk '{print " ║ " $2}'
    echo " ╚══════════════════════════╝"
    echo " ╔═══════════UTILS══════════╗"
    echo " ║ z                        cd but with natural language"
    echo " ║ y                        File explorer → Enter to cd to dir"
    echo " ║ zfzf                     Fuzzy search → Enter to open in editor (Zed)"
    echo " ║ btop/btm                 Process monitor (TODO- get good flags)"
    echo " ║ setc [n]                 Set \$c to n (use setcc for \$cc)"
    echo " ║ reload                   Reload Fish"
    echo " ╚══════════════════════════╝"
    echo " ╔═══════CHEATSHEETS════════╗"
    echo " ║ cht                     Show this cheatsheet"
    echo " ║ chtconfig               Common config-related sheet"
    echo " ║ chtfish                 Fish cheatsheet"
    echo " ╚══════════════════════════╝"
    echo " ╔═══════════OTHER══════════╗"
    echo " ║ cd ~/.config && y       Go to config directory (manage functions in /fish/functions)"
    echo " ╚══════════════════════════╝"
    echo " ╔══════════ALIASES═════════╗"
    echo " ║ \$H, \$A, \$V, \$c, and \$cc"
    echo " ╚══════════════════════════╝"
    echo " ├── \$c  ─ $c"
    echo " └── \$cc ─ $cc"
    echo ""
end
