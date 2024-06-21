#!/usr/local/bin/bash
set -euo pipefail
shopt -s nullglob
inboxdir=$HOME/tunes/inbox

# expand zips
for zip in "$inboxdir"/zipped/*.zip; do
    name=${zip%.zip}
    name=$(basename "$name")
    dirpath="$inboxdir/unzipped/$name"

    mkdir "$dirpath"
    unzip "$zip" -d "$dirpath"
    trash "$zip"
done

# import albums, moving (not copying) successfully imported files
beet import -imq -l "$inboxdir/beet-import.log" "$inboxdir/unzipped/"*

# go through directories and remove any that only contain a cover image (a.k.a. ones that were successfully imported)
for dir in "$inboxdir/unzipped/"*; do
    dircontents="$(ls -A1 "$dir" | grep -vxF .DS_Store)" # filter .DS_Store
    if [[ "$dircontents" = "cover."* ]] && # file found is a cover
    [[ "$(echo "$dircontents" | wc -l)" -eq 1 ]] # only one file found
    then
        trash "$dir"
    fi
done

