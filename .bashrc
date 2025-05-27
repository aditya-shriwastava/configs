alias fopen='xdg-open'
alias t='tmux'
alias v='nvim'
alias r='ranger'
alias p='python3'

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='[${PWD/*\//}]$(git_branch)>>'
PS1="\[\e[0;32m\]$PS1\[\e[m\]"
export PS1

set -o vi
bind -m vi-insert "\C-l":clear-screen
