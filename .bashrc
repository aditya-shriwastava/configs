alias python='/usr/bin/python3'
alias dpush='git add .;git commit -m "X";git push;git status'
alias fopen='xdg-open'

# usage:
# reminder <description> <minutes>
function reminder() {
	reminder_duration=$2
	for min_passed in $(seq $reminder_duration)
	do
		for sec_passed in {1..60}
		do
			clear
			echo "Reminder:"
			echo "  Task          : $1"
			echo "  Duration      : $2 minutes"
			echo "  Time Remaining: $(( reminder_duration - min_passed )):$(( 60 - sec_passed )) minutes"
			sleep 1
		done
	done
	notify-send -t 0 -i gtk-dialog-info Alarm "$1"
	echo "Playing Notification sound START"
	play ~/Music/alarm.mp3 > /dev/null 2>&1
	echo "Playing Notification sound END"
}

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='[${PWD/*\//}]$(git_branch)>>'
PS1="\[\e[0;32m\]$PS1\[\e[m\]"
export PS1

set -o vi
