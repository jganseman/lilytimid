# lilytimid
A set of scripts for dealing with directory trees of Lilypond files

## About
These scripts were originally written to batch-process (part of) the
[Mutopia](http://www.mutopiaproject.org/) database of 
[Lilypond](http://lilypond.org) music scores, piping 
it through the [Timidity++](http://timidity.sourceforge.net/) synthesizer, 
in order to create a dataset for use in score-informed audio source 
separation projects. If you any of these files useful, please consider 
citing [the following paper](https://ccrma.stanford.edu/~jga/icmc2010/icmc2010.html), 
which it was developed for:
```
@InProceedings{Ganseman2010,
  Title     = {Source separation by score synthesis},
  Author    = {Ganseman, J. and Mysore, G.J. and Scheunders, P. and Abel, J.S.},
  Booktitle = {Proc. International Computer Music Conference (ICMC 2010)},
  Year      = {2010},
  Month     = {June},
  Address   = {New York, NY},
  Pages     = {462-465},
  Url       = {https://ccrma.stanford.edu/~jga/icmc2010/icmc2010.html}
}
```

Mutopia's files can be downloaded from their 
[FTP directory](http://www.mutopiaproject.org/ftp/).

## Contents
There are 7 Bash scripts in this directory, which assume the directory 
structure is read/writable by the user and that Lilypond and Timidity 
are installed:

* `zipdirs.sh` / `unzipdirs.sh`: (Un)zip all subdirectories in a given directory
* `prunefiletype.sh`: Remove subdirs that don't contain a given amount of a given filetype
* `extractfiles.sh`: Extract all files with a given extension from a directory tree
* `updately.sh`: Try to update all Lilypond files to the most recent version
* `lilybatch.sh`: Run lilypond on all applicable files in a directory tree (.ly -> .mid)
* `timidibatch.sh`: Run Timidity on all applicable files in a directory tree (.mid -> .wav)

## Disclaimer
All of this was written in 2009-2010 and has not been updated since.
No guarantee is given that it still works on recent Linux distros, 
with recent versions of Lilypond, or with more recent Mutopia files. 
These scripts are just published FYI, hence all use is at your own risk ;)
