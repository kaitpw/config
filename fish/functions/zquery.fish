function zquery
    zoxide query -l -s | \
    head -n 5 | \
    sed "s|/Users/kai-admin|~|g" | \
    awk '{print "     * " $2}'
end

# ➤ zquery
# ~/A/PE/pm-upgrade/qr-repo
# ~/A/PE
# ~/A/PE/pm-upgrade/qr-repo/components
# ~/Library/Application
# ~/.config/fish
