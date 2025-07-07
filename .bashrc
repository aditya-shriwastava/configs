alias fopen='xdg-open'
alias t='tmux'
alias v='nvim'
alias r='ranger'
alias p='python3'

git_branch() {                                                                                                                                                                                
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'                                                                                                                           
}   
PS1='\[\e[0;34m\][\W|\h]$(git_branch)>>\[\e[m\] '
export PS1

set -o vi
bind -m vi-insert "\C-l":clear-screen

source /usr/share/doc/fzf/examples/key-bindings.bash
export EDITOR=nvim
