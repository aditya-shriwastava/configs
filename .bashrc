#!/bin/bash
alias python='/usr/bin/python3'
alias dpush='git add .;git commit -m "X";git push;git status'
alias fopen='xdg-open'
alias fexp='nautilus'

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='[${PWD/*\//}]$(git_branch)>>'
PS1="\[\e[0;32m\]$PS1\[\e[m\]"
export PS1

set -o vi
