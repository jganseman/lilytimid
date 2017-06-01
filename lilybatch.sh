#!/bin/bash

# shell script to run lilypond on all .ly files in a directory structure
# all options will be passed to the lilypond command line

# by Joachim Ganseman

    # first argument must be dir-structure root on which to operate
if [ $# -le 1 ]
then
    echo "Usage - $0  MyDirectoryName AllArgumentsToLilypond"
    exit 1
fi

# dev comment: name=var, put no spaces around '=' sign!
olddir=`pwd`	# save current directory to return to later
newdir=$1

if [ -d $1 ]; then
  echo "running lilypond on .ly files recursively in directory $1" 
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
		lilypond ${@:2} $j & > /dev/null 2>&1	# :2 selects 2->end
		;;			# and pipe output to null
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