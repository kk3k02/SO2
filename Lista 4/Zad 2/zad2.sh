#!/bin/bash

# W zadanym pliku tekstowym (zawierającym znaki tabulacji) zastąpić
# znaki tabulacji przez odpowiednią liczbę spacji. Założyć, że znak
# tabulacji powinien przesunąć tekst w prawo o taką liczbę spacji,
# aby początek następnego słowa znalazł się w kolumnie n*$2,
# gdzie $2 jest liczbą całkowitą zadaną w drugim parametrze
# skryptu a n najmniejszą liczbą całkowitą dodatnią, taką że
# tabulacja przesunie tekst w prawo
# (tak jak działa tabulator domyślny w procesorze tekstu).

# Check if the amount of the arguments is different from 2
if [ "$#" -ne 2 ]; then
    echo "Wrong amount of the arguments!"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "File $1 does not exist..."
    exit 1
fi

# Check if the tab width is a positive integer
if ! [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
    echo "Tab width must be a positive integer..."
    exit 1
fi

# Calculate the number of spaces per tab
tab_width="$2"
num_spaces=$(( tab_width - 1 ))

# Replace tabs with spaces, preserving comments
awk -v num_spaces="$num_spaces" '/^#/ || gsub(/\t/, sprintf("%*s", num_spaces, ""))' "$1"

