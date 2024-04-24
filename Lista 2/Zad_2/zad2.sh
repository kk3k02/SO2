#!/bin/bash

# W zadanym katalogu ($1) przerob wsztstkie dowiazania symboliczne,
# zdefiniowane sciezkami wzglednymi, na rownowazne zdefiniowane
# sciezkakmi bezwzglednymi.

# Check if the amount of the arguments is different from 1
if [ "$#" -ne 1 ]; then
    echo "Wrong amount of the arguments!";
    exit 1;
fi;

# Check if the argument is dir
if [ ! -d "$1" ]; then
    echo "Directory $1 does not exist!";
    exit 1;
fi;

# Chceck all the files in the dir
for link in "$1"/*; do
    # Check if the file has symbolic link
    if [ -h "$link" ]; then
	# Target path to the symbolic link
	target=$(readlink -f "$link");

	# Check if the path is relative
	if [[ "$target" != /* ]]; then
	    # Replace relative path with absolute path
	    absolute_target=$(realpath "$target");

	    # Update the symbolic link
	    ln -sf "$absolute_target" "$link";
	fi;
    fi;
done;
