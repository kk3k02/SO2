#!/bin/bash

# W zadanym katalogu ($1) znajdź dowiązania symboliczne do obiektów w tym samym katalogu $1 i usuń je. 

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Wrong amount of arguments!"
    exit 1
fi

# Check if the argument is a directory
if [ ! -d "$1" ]; then
    echo "Directory $1 does not exist!"
    exit 1
fi

# Get the canonical path of the provided directory
canonical_directory=$(readlink -f "$1")

# Loop over all the files in the directory
for file in "$1"/*; do
    # Check if the file is a symbolic link
    if [ -L "$file" ]; then
        # Get the target path
        target=$(readlink "$file")

        # Get the canonical path to the target item
        canonical_target=$(readlink -f "$1/$target")

        # Check if the canonical target path starts with the canonical directory path
        if [[ "$canonical_target" == "$canonical_directory"* ]]; then
            rm "$file"
            echo "Symbolic link $file pointing to a file in the same directory has been removed"
        fi
    fi
done

echo "Done"
