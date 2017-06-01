#!/bin/bash

# shell script to remove directories with less than x files of given filetype
# by Joachim Ganseman


    # first argument must be dir-structure root on which to operate
if [ $# -ne 3 ]
then
    echo "Usage - $0  MyDirectoryName MyExtension MinNrOfFiles"
    exit 1
fi

# dev comment: name=var, put no spaces around '=' sign!
olddir=`pwd`	# save current directory to return to later
newdir=$1
extension=$2
minnroffiles=$3

if [ -d $1 ]; then
	echo "Pruning directory: removing directories under $1 if there are less than $3 $2 files." 
	cd $1
else
	echo "directory $1 does not exist."
	exit 1
fi

# get absolute path of directory from which the 
scriptdir=`pwd`

for i in `ls -R | grep ./ | sort -r`; do		# have results reversed, to do subdirs first
  # cut out the ./ in front and the and the : in the end 
  curdir=` echo $i |  sed s/.$//`			#cut -c 3- |

  if [ -d $curdir ]; then

    # enter the directory
    cd $curdir

    #check if the directory is empty or not
    if [ "$(ls -A)" ]; then		# seems that `` wont work
      echo "$curdir is not empty"
      
      # find nr of files with given extension in the directory
      filecount=` ls | grep -i .*$extension | wc -l`
      echo "   filecount $filecount"

      if [ $filecount -lt $minnroffiles ]; then
	# delete! but only if leaf dir or if all subdirs are empty
	nrofsubdirs=`find . -maxdepth 1 -type d  | wc -l`		# always finds ./
	if [ $nrofsubdirs -le 1 ]; then		# leaf directory without useful files -> delete!
	  echo "$curdir has no useful files. Deleting"
	  cd $scriptdir
	  rm -Rf $curdir

	else		# only delete if all subdirs are empty
# 	  filesinsubdir=0
# 	  for mysubdir in `find . -maxdepth 1 -type d | grep ./`; do		# list all subdirs
# 	    cd $mysubdir
# 	    if [ `ls -R | grep -i .*$extension | wc -l` -gt 0 ]; then			# see which ones contain data
# 	      (( filesinsubdir++ ))
# 	    fi
# 	    cd ..
# 	  done
# 	  if [ $filesinsubdir -eq 0 ]; then	# no files underneath this one - delete
# 	    echo "$curdir contains only empty directories. Deleting"
# 	    cd $scriptdir
# 	    # rm -Rf $curdir
# 	  else
# 	    echo "$curdir contains $filesinsubdir useful files... we keep this one."
# 	  fi

	  # other approach: only delete if no files with extension are present
	  # since we work bottom-up, this should already have deleted previous singlefile dirs
	  recfilecount=`ls -R | grep -i .*$extension | wc -l`
	  if [ $recfilecount -gt 0 ]; then
	    echo "$curdir contains useful files... we keep this one."
	  else
	    echo "$curdir subdirs contains no interesting files. Deleting"
 	    cd $scriptdir
 	    rm -Rf $curdir
	   
	  fi
	fi
      fi

    else	# directory empty? delete it anyway
      echo "$curdir is empty. Deleting"
      cd $scriptdir
      rmdir $curdir
    fi

    cd $scriptdir
  else
    echo "WARNING $curdir was not a directory. continuing…"
  fi
done

echo "Finished"

cd $olddir		