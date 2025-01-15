#!/bin/bash
ssh-keygen -lvf "$1"

echo
echo "md5 hash:"
awk '{print $2}' ~/.ssh/id_ed25519.pub | base64 -d | md5 | sed 's/../&:/g; s/: .*$//' | rev | cut -c "2-" | rev
