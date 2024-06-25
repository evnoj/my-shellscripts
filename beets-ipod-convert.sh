#!/usr/local/bin/bash
# converts the albums found in ~/tunes/ipod-albums-list.txt into ipod-appropriate format and puts them in the Music.app folder that will automatically import them the next time Music.app is open

cat ~/tunes/ipod-albums-list.txt |
kak -f 's::<ret>lGhd' |
tr '\n' '\0' |
xargs -0 -n1 -P0 -I {} beet convert -d '~/Music/Apple Music/Automatically Add to Music.localized' -f ipod -a -y "album:={}"
