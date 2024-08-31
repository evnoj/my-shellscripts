#!/bin/bash

# Usage: ./script.sh /path/to/directory
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

mkdir "$1/raws"
mkdir "$1/jpgs"

for file in "$1"/*".JPG"; do
    mv "$file" "$1/jpgs"
done

for file in "$1"/*".ARW"; do
    mv "$file" "$1/raws"
done

