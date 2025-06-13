#!/usr/local/bin/bash
# converts the albums found in the argument (ex. ~/tunes/ipod-albums-list.txt) into ipod-appropriate format and puts them in the Music.app folder that will automatically import them the next time Music.app is open
# to generate ipod-albums-list in the correct format, run:
# beets ls -af '$albumartist :: $album' > ~/tunes/albums-list.txt

cat "$1" |
kak -f 's::<ret>lGhd' |
tr '\n' '\0' |
xargs -0 -n1 -P0 -I {} beets convert -d '~/tunes/ipod-exports' -f ipod -a -y "album:={}"
