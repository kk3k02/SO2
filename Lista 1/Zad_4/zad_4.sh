#!/bin/bash

# Check if the amount of arguments is different from 2
if [  $# -ne 2 ]; then
    echo "Wrong amonut of arguments!";
    exit 1;
fi;

directory="$1"
file_list="$2"

# Check if directory exist
if [ ! -d "$directory" ]; then
    echo "Directory "$directory" does not exist!";
    exit 1;
fi;

# Check if the file exist
if [ ! -f "$file_list" ]; then
    echo "File "$file_list" does not exist!";
    exit 1;
fi;

# Read the file
while IFS= read -r file; do
    # Create path to new file
    target_file="$directory/$file";
    # Check if the new file already exist in directory
    if [ ! -e "$target_file" ]; then
    # Create file without write permission
	touch "$target_file";
	chmod a-w "$target_file";
    fi;
done < "$file_list";

echo "Done.";








