#!/bin/bash

# Dla zadanych dwóch drzew katalogów utworzyć trzecie,
# będące częścią wspólną dwóch pierwszych. Aby utworzyć kopię,
# pliki/katalogi/dowiązania muszą się w obu tak samo nazywać
# i mieć ten sam typ. Zawartość pliku regularnego lub ścieżka
# dowiązania są nieistotne. W kopii zawsze jest to kopia z drzewa pierwszego.

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Wrong amount of the arguments...";
    exit 1;
fi;

# Assign arguments to variables
TREE1=$1;
TREE2=$2;

# Create the output directory
OUTPUT_DIRECTORY="${TREE1}_and_${TREE2}_common";
mkdir -p "$OUTPUT_DIRECTORY";

find "$TREE1" -type d -o -type f -o -type l | while IFS= read -r -d '' file; do
    # Extract the filename from the path
    file1=$(basename "$file");
    # Check if the file exists in TREE2 and has the same type and name
    if [ -e "$TREE2${file#$TREE1}" ] && [ "$(stat -c "%F" "$file")" = "$(stat -c "%F" "$TREE2${file#$TREE1}")" ] && [ "$file1" = "$(basename "$TREE2${file#$TREE1}")" ]; then
        if [ -d "$file" ]; then
            # If it's a directory, create directory in OUTPUT_DIRECTORY if it doesn't exist
            mkdir -p "$OUTPUT_DIRECTORY${file#$TREE1}";
        elif [ -f "$file" ]; then
            # If it's a regular file, copy the file from TREE1 to OUTPUT_DIRECTORY
            cp -a "$file" "$OUTPUT_DIRECTORY${file#$TREE1}";
        elif [ -L "$file" ]; then
            # If it's a symbolic link, recreate the link in OUTPUT_DIRECTORY
            ln -s "$(readlink -f "$file")" "$OUTPUT_DIRECTORY${file#$TREE1}";
        fi
    fi
done

echo "Done";
