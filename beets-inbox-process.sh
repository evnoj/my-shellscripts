#!/usr/local/bin/bash
set -euo pipefail
shopt -s nullglob
inboxdir=$HOME/tunes/inbox

# pass 'all' to do a full import of everything in the inbox, manually prompting for user actions if unsure, and not skipping anything
if [ "${1:-}" = "all" ]; then
    importflags="-m"
# pass 'asis' to import with the metadata they have, don't tag from MusicBrainz
elif [ "${1:-}" = "asis" ]; then
    importflags="-mA"
# 'hybrid' will attempt to tag via musicbrainz, if that fails, it is imported as is
elif [ "${1:-}" = "hybrid" ]; then
    importflags="-imq --quiet-fallback asis"
else
# if nothing is passed, it tries to tag via MusicBrainz, then skips if it can't
    importflags="-imq"
fi

# expand zips
for zip in "$inboxdir"/zipped/*.zip; do
    name=${zip%.zip}
    name=$(basename "$name")
    dirpath="$inboxdir/unzipped/$name"

    mkdir "$dirpath"
    # unzip "$zip" -d "$dirpath"
    # this properly detects and deals with different character encodings in filenames
    /usr/local/opt/unzip/bin/unzip -I "$(chardetect --minimal <<<"$zip")" "$zip" -d "$dirpath"
    trash "$zip"
done

# import albums, moving (not copying) successfully imported files
# use beets installed in my user-utilities venv
~/.venv/bin/python -m beets import $importflags -l "$inboxdir/beet-import.log" "$inboxdir/unzipped/"*

# go through directories and remove any that only contain a cover image (a.k.a. ones that were successfully imported)
for dir in "$inboxdir/unzipped/"*; do
    set -- "$dir"/*
    # if only 1 file and its a cover
    if [[ "$#" == 1 ]] && [[ $(basename "$1") == cover.* ]]
    then
        trash "$dir"
    fi
    
    # dircontents="$(ls -A1 "$dir" | grep -vxF .DS_Store)" # filter .DS_Store
    # if [[ "$dircontents" = "cover."* ]] && # file found is a cover
    # [[ "$(echo "$dircontents" | wc -l)" -eq 1 ]] # only one file found
    # then
    #     trash "$dir"
    # fi
done

