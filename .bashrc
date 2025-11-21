alias fopen='xdg-open'
alias t='tmux'
alias v='nvim'
alias r='ranger'
alias p='python3'

# Function to display current git branch
git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Function to show remote indicator
REMOTE=False
remote_indicator() {
    [[ "$REMOTE" == "True" ]] && echo "🌐 " || echo ""
}

# Prompt configuration
# Format: [remote_icon][current_directory|hostname](git_branch)>>
# Color: Green text with color reset at the end
# Shows 🌐 icon if REMOTE=True
PS1='$(remote_indicator)[${PWD/*\//}|\h]$(git_branch)>>'
PS1="\[\e[0;32m\]$PS1\[\e[m\]"
export PS1

set -o vi
bind -m vi-insert "\C-l":clear-screen

source /usr/share/doc/fzf/examples/key-bindings.bash
export EDITOR=nvim

journal() {
    local today=$(date +%Y-%m-%d)
    local journal_dir="$HOME/journal/$today"
    local journal_file="$journal_dir/journal.md"

    # Create directory if it doesn't exist
    mkdir -p "$journal_dir"

    # Create file if it doesn't exist
    touch "$journal_file"

    # Open with editor
    if [ -n "$EDITOR" ]; then
        "$EDITOR" "$journal_file"
    elif command -v vim >/dev/null 2>&1; then
        vim "$journal_file"
    elif command -v nano >/dev/null 2>&1; then
        nano "$journal_file"
    else
        vi "$journal_file"
    fi
}

