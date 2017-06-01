#!/bin/bash

#shell script to sift all files of a given directory so that only those
# with a given extension remain. Creates new directory structure and 
# copis the files

# by Joachim Ganseman

if [ $# -ne 2 ]
then
    echo "Usage - $0  MyDirectoryName ExtensionToExtract"
    exit 1
fi

# dev comment: name=var, put no spaces around '=' sign!
olddir=`pwd`	# save current directory to return to later
newdir=$1
extension=$2

if [ -d $1 ]; then
	echo "extracting files from directory $1" 
	cd $1
else
	echo "directory $1 does not exist."
	exit 1
fi

# now we are in directory $1 which is the root of our file system
# create new directory in dir where script is run from

dirname=`pwd | awk -F / '{print $NF}'`
extname=`echo $2 | awk -F . '{print $NF}'`	#get last letters of extension
newroot=${olddir}/${dirname}${extname}
mkdir $newroot
scriptdir=`pwd`


#for all dirs. from the old directory, create a new directory in new root

for i in `ls -R | grep ./`; do
		# cut out the ./ in front and the and the : in the end 
	curdir=` echo $i |  sed s/.$//`			#cut -c 3- |

	if [ -d $curdir ]; then
		echo "processing directory ${curdir}"
		mkdir ${newroot}/${curdir}
		
		# enter the directory
		cd $curdir
		
		# for all things in this directory, if they are files with an extension that
		# corresponds to the given extension, copy them to the new dirstructure
		for j in *; do
			if [ -f $j ]; then
				case $j in 
					*${2})
						echo "copying file $j"
						cp $j ${newroot}/${curdir}
						;;
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

