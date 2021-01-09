alias python='/usr/bin/python3'
alias dpush='git add .;git commit -m "X";git push;git status'

# usage:
# alarm <description> <minutes>
function alarm() {
	echo "Alarm:"
	echo "  Description: $1"
	echo "  Duration   : $2 minutes"
	alarm_duration=$2
	for time_passed in $(seq $alarm_duration)
	do
		sleep 60
 		echo "Time Remaining: $(( alarm_duration - time_passed )) minutes"
	done
	notify-send -t 0 -i gtk-dialog-info Alarm "$1"
	play ~/Music/alarm.mp3
}

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='[${PWD/*\//}]$(git_branch)>>'
PS1="\[\e[0;32m\]$PS1\[\e[m\]"
export PS1

