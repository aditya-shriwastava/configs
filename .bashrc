#!/bin/bash
alias python='/usr/bin/python3'
alias dpush='git add .;git commit -m "Update";git push;git status'
alias fopen='xdg-open'

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='[${PWD/*\//}]$(git_branch)>>'
PS1="\[\e[0;32m\]$PS1\[\e[m\]"
export PS1

set -o vi

cpfile(){
  readlink -f "$1" | xclip -selection clipboard
}

alias clss='rm ~/Pictures/Screenshot*'
