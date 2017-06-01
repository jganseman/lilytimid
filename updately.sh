#!/bin/bash

#shell script to update the version number on all .ly files in a directory structure
# uses the standard convert-ly script provided by the operating system

# by Joachim Ganseman


if [ $# -ne 1 ]
then
    echo "Usage - $0  MyDirectoryName"
    exit 1
fi

# dev comment: name=var, put no spaces around '=' sign!
olddir=`pwd`	# save current directory to return to later
newdir=$1

if [ -d $1 ]; then
	echo "updating lilypond files recursively in directory $1" 
	cd $1
else
	echo "directory $1 does not exist."
        exit 1
fi

# get absolute path of directory from which the 
scriptdir=`pwd`

# go recursively through the file structure

for i in `ls -R | grep ./`; do
		# cut out the ./ in front and the and the : in the end 
	curdir=` echo $i |  sed s/.$//`			#cut -c 3- |

	if [ -d $curdir ]; then
	
		# enter the directory
		cd $curdir
		
		# for all things in this directory, if they are files with an extension .ly,
		# run the update command
		for j in *; do
			if [ -f $j ]; then
				case $j in 
					*.ly)
						echo "updating file $j"
						convert-ly -c -e $j & > /dev/null 2>&1	# -e does inline edit
						;;			# -c forces version
					*)
						;;
				esac
			fi
		done
		
		#go back to this script's processing directory
		cd $scriptdir
	else
		echo "WARNING $curdir was not a directory. continuing…"
	fi
done

echo "Finished"

cd $olddir	