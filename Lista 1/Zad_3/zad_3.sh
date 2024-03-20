#!/bin/bash

# Check if the amount of arguments is different from 1
if [ $# -ne 1 ]; then
    echo "Wrong amount of arugments!";
    exit 1;
fi;

directory="$1"

# Check if directory exist
if [ ! -d "$directory" ]; then
    echo "Directory "$directory" does not exist!";
    exit 1;
fi;

# Delete files with .old extension
for old_file in "$directory"/*.old; do
    # Check if old_file exist
    if [ -f "$old_file" ]; then
	rm "$old_file";
    else
	echo "Error during proccesing "$old_file" file!";
    fi;
done;

# Add extension .old to file
for file in "$directory"/*; do
    # Check if file has read and write permission
    if [ -r "$file" ] && [ -w "$file" ]; then
	mv "$file" "$file.old";
    fi;
done;

echo "Done.";
