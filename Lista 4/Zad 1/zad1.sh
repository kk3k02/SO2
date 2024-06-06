#!/bin/bash

# Sprawdz, czy zadany plik jest tekstowy. Kryteria:
# -dlugosc linii < 128 znakow;
# -plik zawiera znaki ASCII bez znakow sterujacych (poza nowa linia)
# Zidentyfikuj, czy jest to plik w formacie tekstowym DOS/Windows,
# czy UNIX/Linux (na podstawie znakow na koncu wiersza).

# Check if the amount of the arguments is different from 1
if [ "$#" -ne 1 ]; then
    echo "Wrong amount of arguments...";
    exit 1;
fi;

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "File $1 does not exist...";
    exit 1;
fi;

# Check line length
if [[ $(awk '{ if (length($0) > 128) { print 1; exit 1; }}' "$1") ]]; then
    echo "The file is not a text file due to exceeding line length...";
    exit 1;
fi;

# Check ASCII characters
if grep -q '[^[:print:][:space:]\n]' "$1"; then
    echo "The file contains non-printable characters";
    exit 1;
fi;


# Count occurrences of '\n' and '\r\n' using 'grep' command
unix_endings=$(grep -c $'\n' "$1");
dos_endings=$(grep -c $'\r\n' "$1");

# Determine file format based on line endings
if [[ $dos_endings -gt 0 && $unix_endings -eq 0 ]]; then
    echo "The file has DOS/Windows text format...";
elif [[ $unix_endings -gt 0 && $dos_endings -eq 0 ]]; then
    echo "The file has UNIX/Linux text format...";
else
    echo "Unable to determine the file format...";
fi;
