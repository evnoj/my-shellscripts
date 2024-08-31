#!/bin/bash
#
# this script is intended for making smaller-res versions of the images imported from a camera, so they can be browsed more quickly (since they load faster) to take out poor/duplicate photos, leaving high-quality photos to go through in a photo editor

# Usage: ./script.sh /path/to/directory
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

mkdir "$1/low-res"

files=("$1/"*".JPG")
parallel -j 10 convert -resize 50% {} "$1/low-res/{/}" ::: "${files[@]}"

# for file in "$1/"*".JPG"; do
#     basename=$(basename "$file")
#     convert -resize 50% "$1/$file" "$1/low-res/$basename"
# done

