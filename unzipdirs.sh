#!/bin/bash

#shell script to zip up all contents of a directory
# by Joachim Ganseman

echo "Warning - script has not yet been tested…"

if [ $# -ne 1 ]
then
    echo "Usage - $0  MyDirectoryName"
    exit 1
fi

# dev comment: name=var, put no spaces around '=' sign!
curdir=`pwd`	# save current directory to return to later
newdir=$1

if [ -d $1 ]; then
	echo "unzipping folders in dir $1" 
	cd $1
else
	echo "directory $1 does not exist."
	  exit 1
fi

for i in *; do
  if [ -f "$i" ]; then
	case $i 
		*.tar.gz)
			echo "unzipping $i."
			tar -xfz $i
			;;
		*.tgz)
			echo "unzipping $i."
			tar -xfz $i
			;;
		*)	
			echo "NOT unzipping $i - unknown extension."
			;;
	esac
  else
    if [ -x "$i" ]; then
      echo "$i is executable, skipping."
    else
      if [ -d "$i" ]; then
        echo "$i is a directory, skipping."
      else
        echo "$i is a UFO, skipping."
      fi
    fi
  fi
done

echo "Finished"

cd $curdir