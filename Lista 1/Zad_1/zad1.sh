#!/bin/bash

# Check if the number of arguments is different from 2
if [ $# -ne 2 ]; then
    echo "Wrong amount of arguments!";
    exit 1;
fi;

directory="$1";
extension="$2";
output_file="combined_file.txt";

# Check if directory exist
if [ ! -d "$directory" ]; then
    echo "Directory "$directory" does not exist!";
    exit 1;
fi;

# Create or overwrite output file
> "$output_file";

# Loop for all the files in the directory
for file in "$directory"/*."$extension"; do
    # Check if the file exist and if it is readable
    if [ -f "$file" ] && [ -r "$file" ]; then
	# Add heading to output file
	echo "$(basename "$file")" >> "$output_file";
	# Add file contents to output file
	cat "$file" >> "$output_file"
	# Add empty line
	echo >> "$output_file"
    else
	echo "Error during proccessing the file: "$file"";
    fi;
done;

echo "Done.";


