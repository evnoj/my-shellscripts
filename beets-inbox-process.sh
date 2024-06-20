#!/bin/zsh
set -euo pipefail

inboxdir=$HOME/tunes/inbox
for zip in $inboxdir/zipped/*.zip; do
    name=${zip%.zip}
    name=$(basename "$name")
    dirpath="$inboxdir/unzipped/$name"

    mkdir "$dirpath"
    unzip "$zip" -d "$dirpath"
    trash "$zip"
done

    
