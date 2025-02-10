#!/bin/bash

if [ -z ${1+x} ]; then
    name="norns"
else
    name="norns-$1"
fi
hostname="$name.local"

if [ -z ${2+x} ]; then
    rlwrap websocat --protocol bus.sp.nanomsg.org "ws://$hostname:5555" | stdbuf -i0 -o0 ssh "$name" "journalctl --output=cat -fu norns-matron"
else
    echo "$2" | websocat --one-message --protocol bus.sp.nanomsg.org "ws://$hostname:5555"
fi

