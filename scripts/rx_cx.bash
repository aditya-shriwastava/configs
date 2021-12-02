#!/bin/bash
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
