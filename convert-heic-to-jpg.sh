#!/bin/zsh
# converts all files in the passed directory (or pwd if not provided) with a .heic or .HEIC extension to a jpg, with the same pre-extension filename
# jpgs are output in the pwd
# requirements: macOS

setopt nullglob

1="${1:-.}"

for i in "$1"/*.heic(:r); do
    sips -s format jpeg -s formatOptions best "$i.heic" --out "$i.jpg"
done

for i in "$1"/*.HEIC(:r); do
    sips -s format jpeg -s formatOptions best "$i.HEIC" --out "$i.jpg"
done
