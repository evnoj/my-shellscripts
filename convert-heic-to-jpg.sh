#!/bin/zsh
# converts all files in the pwd with a .heic or .HEIC extension to a jpg, with the same pre-extension filename
# jpgs are output in the pwd
# requirements: macOS

setopt nullglob

for i in *.heic(:r); do
    sips -s format jpeg -s formatOptions best "$i.heic" --out "$i.jpg"
done

for i in *.HEIC(:r); do
    sips -s format jpeg -s formatOptions best "$i.HEIC" --out "$i.jpg"
done
