#!/bin/bash

# Check if the amount of arguments is different from 1
if [ $# -ne 1 ]; then
    echo "Wrong amount of arguments!";
    exit 1;
fi;

directory="$1";

# Check if the directory exist
if [ ! -d "$directory" ]; then
    echo "Directory "$directory" does not exist!";
    exit 1;
fi;

# Remove all files from directory
for file in "$directory"/*; do
    # Check if the file exist
    if [ -f "$file" ]; then
	# Check if the file has permission to execute
	if [ ! -x "$file" ]; then
	    rm "$file";
	fi;
    fi;
done;

echo "Done.";