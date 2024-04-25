#!/bin/bash

# W zadanym drzewie katalogow znalezc dowiazania symboliczne
# ,,wiszace" (nie wskazujace na istniejace obiekty)

# Check if  the amount of argument is different from 1
if [ "$#" -ne 1 ]; then
	echo "Wrong amount of arguments...";
	exit 1;
fi;

# Check if the argument type is directory
if [ ! -d "$1" ]; then
	echo "$1 is not a directory...";
	exit 1;
fi;

find "$1" -type l ! -exec test -e {} \; -print;
