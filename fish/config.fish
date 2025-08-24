# New welcome greeting
if status is-interactive
    echo "*************** 🔒← buddy 🤑, help is below ***************"
    echo ""
    cht
end

eval "$(/opt/homebrew/bin/brew shellenv)"

# Disable default fish login greeting
set fish_greeting ""
# Personal aliases
set -gx H "$HOME"
set -gx A "$HOME/A/"
set -gx V "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/V"
# set -gx c "/Users/kai-admin/A/PE/pm-upgrade/qr-repo"

# Set the default command for fzf to use fd with node_modules excluded
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude node_modules --exclude .git'

# Make sure CTRL-T binding uses the same command but respects the current directory
set -gx FZF_CTRL_T_COMMAND "fd --type f --hidden --follow --exclude node_modules --exclude .git . \$dir"
set -gx FZF_DEFAULT_OPTS "
    --height=80%
    --min-height=30
    --layout=reverse
    --info=inline
    --border
    --margin=1
    --padding=1
    --preview='bat --color=always {}'
"

# Initialize zoxide
zoxide init fish | source

# pnpm
set -gx PNPM_HOME "/Users/kai-admin/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
