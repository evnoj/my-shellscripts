#!/usr/local/bin/bash
# $1: common base. the name of a temporary file containing the common base for the merge, if available
# $2: current branch. the name of a temporary file containing the contents of the file on the current branch
# $3: incoming branch. the name of a temporary file containing the contents of the file to be merged
# $4: the merged file. the name of the file to which the merge tool should write the result of the merge resolution

id="$(uuidgen)"
mkfifo "/tmp/$id"
zellij run --floating --height 50% --width 50% -x 50% -y 0 -- delta "$1" "$2"
zellij run --floating --height 50% --width 50% -x 50% -y 50% -- delta "$1" "$3"
zellij run --close-on-exit --floating --height 100% --width 50% -x 0 -y 0 -- zsh -c "kak $4 && echo done | tee /tmp/$id"
cat < "/tmp/$id" > /dev/null
rm "/tmp/$id"
