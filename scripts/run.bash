#!/bin/bash
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
