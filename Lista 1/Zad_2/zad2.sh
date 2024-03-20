#!/bin/bash

# Check if the amount of arguments is different from 2
if [ $# -ne 2 ]; then
    echo "Wrong amount of the arguments!";
    exit 1;
fi;

source_dir="$1";
target_dir="$2";

# Check if source directory exist
if [ ! -d "$source_dir" ]; then
    echo "Directory "$source_dir" does not exist!";
    exit 1;
fi;

# Check if target directory exist
if [ ! -d "$target_dir" ]; then
    mkdir "$target_dir";
fi;

# Move files with execute permission from source dir to target dir
for file in "$source_dir"/*; do
    if [ -x "$file" ] && [ -f "$file" ]; then
	mv "$file" "$target_dir";
    fi;
done;

echo "Done.";