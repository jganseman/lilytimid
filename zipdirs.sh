#!/bin/bash

#shell script to zip up all contents of a directory
# by Joachim Ganseman

if [ $# -ne 1 ]
then
    echo "Usage - $0  MyDirectoryName"
    exit 1
fi

# dev comment: name=var, put no spaces around '=' sign!
curdir=`pwd`	# save current directory to return to later
newdir=$1

if [ -d $1 ]; then
	echo "zipping folders in dir $1" 
	cd $1
else
	echo "directory $1 does not exist."
        exit 1
fi

for i in *; do
  if [ -d "$i" ]; then
				# if [ "$i" = "AbtF" ]; then
    		echo "$i is a folder, zipping."
    		tar -cf $i.tar $i
		gzip -9 $i.tar
				# fi
  else
    if [ -x "$i" ]; then
      echo "$i is executable, skipping."
    else
      if [ -f "$i" ]; then
        echo "$i is a file, skipping."
      else
        echo "$i is a UFO, skipping."
      fi
    fi
  fi
done

echo "Finished"

cd $curdir