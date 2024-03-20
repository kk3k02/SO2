#!/bin/bash

# Check if the amount of arguments is different from 1
if [ $# -ne 1 ]; then
    echo "Wrong amount of arguments!";
    exit 1;
fi;

directory="$1";

# Check if directory exist
if [ ! -d "$directory" ]; then
    echo "Directory "$directory" does not exist!";
    exit 1;
fi;

executable_files=();

# Create list of executable files and their size
while IFS= read -r file; do
    if [ -f "$file" ] && [ -x "$file" ]; then
	executable_files+=("$file");
    fi;
done < <(ls -1S "$directory");

counter=1;

# Add numbers to files
for file in "$directory"/*; do
    # Check if file has execute permission
    if [ -x "$file" ]; then
	filename=$(basename "$file");
	extension=".$counter";
	mv "$file" "$directory/$filename$extension";
	((counter++));
    fi;
done;

echo "Done.";