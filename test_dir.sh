#!/bin/bash
if [ -z "$1" ]
  then
    echo "No argument supplied for this script"
	echo "Usage :  $0 DIRECTORY_TO_OPERATE"
	exit
fi
DIR=$1
echo "Directory des sources : $DIR;"
if ! [[ -d "$DIR" ]]; then
    echo "Argument isn't directory"
	echo "Usage :  $0 DIRECTORY_TO_OPERATE"
	exit
fi