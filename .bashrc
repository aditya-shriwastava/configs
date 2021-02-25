#!/bin/bash
alias python='/usr/bin/python3'
alias dpush='git add .;git commit -m "X";git push;git status'
alias fopen='xdg-open'

function runcpp(){
  if [ "$1" == "--help" ]; then
    echo "Usage: runcpp <path to cpp file>"
    return
  fi
  file=$1
  g++ ${file}
  if [[ $? -eq 0 ]]
  then
    ./a.out
    rm ./a.out
  fi
}

function runkl(){
  if [ "$1" == "--help" ]; then
    echo "Usage: runkl <path to kotlin file>"
    return
  fi
  echo "####################################################"
  echo "Compilation Starts"
  echo "####################################################"
  file=$1
  file="$( cut -d '.' -f 1 <<< "${file}" )"
  kotlinc ${file}.kt -nowarn -include-runtime -d ${file}.jar
  echo "####################################################"
  echo "Execution Starts"
  echo "####################################################"
  if [[ $? -eq 0 ]]
  then
    java -jar ${file}.jar
    rm ./${file}.jar
  fi
}

function reminder() {
  if [ "$1" == "--help" ]; then
    echo "Usage: reminder <Task> <Duration in minutes>"
    echo "Press (Space-Bar) ---> To Pause task"
    echo "Press      s      ---> To roll the time fast"
    echo "Press      t      ---> To Terminate task"
    echo "Note: Log is saved in ~/.reminderlog.txt"
    return
  fi
  task=$1
  duration=$2
	reminder_duration=$duration
  END="false"
  while [[ ${END} == "false" ]]
  do
	  for min_passed in $(seq $reminder_duration)
	  do
		  for sec_passed in {1..60}
		  do
			  clear
			  echo "Reminder:"
			  echo "  Task          : ${task}"
			  echo "  Duration      : ${duration} minutes"
			  echo "  Time Remaining: $(( reminder_duration - min_passed )):$(( 60 - sec_passed )) minutes"
        read -n1 -s -t 1 input
        interrupt=$?
        if [[ $input == "" ]] && [[ $interrupt -eq 0 ]]
        then
          echo "Paused!!"
          read -n1
        elif [[ $input == "t" ]] && [[ $interrupt -eq 0 ]]
        then
          duration=$(( min_passed - 1 ))
          echo "Task Terminated after spending ${duration}min"
          break 3  
        elif [[ $input == "s" ]] && [[ $interrupt -eq 0 ]]
        then
          break
        fi
		  done
	  done
	  notify-send -t 0 -i gtk-dialog-info Alarm "$1"
	  echo "Playing Notification sound START"
	  play ~/Music/alarm.mp3 > /dev/null 2>&1
	  echo "Playing Notification sound END"
    printf "Extend: "
    read input
    if [[ ${input} != "" ]]
    then
      duration=$(( duration + input ))     
      reminder_duration=${input}
    else
      END="true"
    fi
  done
  echo "[$(date)] ${task} ${duration}min" >> ~/.reminderlog.txt
}

function rx(){
  if [ "$1" == "--help" ]; then
    echo "Usage: rx <source_start> <source_end> <destination_start>"
    return
  fi
  source_start=$1
  source_end=$2
  destination_start=$3
  destination_file_index=${destination_start}
  for source_index in $(seq $source_start 1 $source_end)
  do
    source_file="X ${source_index}.jpg"
    destination_file="${destination_file_index}.jpg"
    mv "${source_file}" ${destination_file}
    echo "${source_file} ---> ${destination_file}"
    sudo chown ${USER} ${destination_file}
    destination_file_index=$(expr ${destination_file_index} + 1)
  done
}

function cx(){
  if [ "$1" == "--help" ]; then
    echo "Usage: cx <start> <end> <target>"
    return
  fi
  start=$1
  end=$2
  target=$3
  input=""
  for i in $(seq $start 1 $end)
  do
    input="${input} ${i}.jpg"
  done
  input="${input} ${target}"
  echo "convert ${input}"
  convert ${input}
}

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='[${PWD/*\//}]$(git_branch)>>'
PS1="\[\e[0;32m\]$PS1\[\e[m\]"
export PS1

set -o vi
