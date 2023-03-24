#!/bin/bash
if [ -z "$1" ]
  then
    echo "No argument supplied for this script"
	echo "Usage :  $0 DIRECTORY_TO_OPERATE"
	exit
fi
if ! [[ -d "$1" ]]; then
    echo "Argument isn't directory"
	echo "Usage :  $0 DIRECTORY_TO_OPERATE"
	exit
fi

cd $1
echo "Directory SRC : $1"

DIRINIT=${PWD}

mkdir $1/bingcc32
mkdir $1/bingcc32/Debug
mkdir $1/bingcc32/Release
mkdir $1/bingcc64
mkdir $1/bingcc64/Debug
mkdir $1/bingcc64/Release
mkdir $1/objgcc32
mkdir $1/objgcc32/Debug
mkdir $1/objgcc32/Release
mkdir $1/objgcc64
mkdir $1/objgcc64/Debug
mkdir $1/objgcc64/Release
mkdir $1/binclang32
mkdir $1/binclang32/Debug
mkdir $1/binclang32/Release
mkdir $1/binclang64
mkdir $1/binclang64/Debug
mkdir $1/binclang64/Release
mkdir $1/objclang32
mkdir $1/objclang32/Debug
mkdir $1/objclang32/Release
mkdir $1/objclang64
mkdir $1/objclang64/Debug
mkdir $1/objclang64/Release
mkdir $1/doxygen
mkdir $1/data
mkdir $1/res
mkdir $1/src
mkdir $1/doc
mkdir $1/doc/pdf
mkdir $1/doc/html
mkdir $1/doc/word
mkdir $1/doc/epub
mkdir $1/doc/mobi
mkdir $1/build.shell
mkdir $1/build.cmake
mkdir $1/build.cmake/gcc32
mkdir $1/build.cmake/gcc32/Debug
mkdir $1/build.cmake/gcc32/Release
mkdir $1/build.cmake/gcc64
mkdir $1/build.cmake/gcc64/Debug
mkdir $1/build.cmake/gcc64/Release
mkdir $1/build.cmake/clang32
mkdir $1/build.cmake/clang32/Debug
mkdir $1/build.cmake/clang32/Release
mkdir $1/build.cmake/clang64
mkdir $1/build.cmake/clang64/Debug
mkdir $1/build.cmake/clang64/Release

cd $DIRINIT
exit 1
