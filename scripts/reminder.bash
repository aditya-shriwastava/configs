#!/bin/bash
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
