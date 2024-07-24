#!/bin/bash

# Function to check if a file is an audio-only WebM
is_audio_only() {
    file="$1"
    output=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=nokey=1:noprint_wrappers=1 "$file")
    if [ "$output" != "vp8" ] && [ "$output" != "vp9" ] && [ "$output" != "av1" ]; then
        return 0  # Audio-only
    else
        return 1  # Contains video
    fi
}

# Recursively search for audio-only WebM files
find_audio_only_webms() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            find_audio_only_webms "$file"
        elif [ "${file##*.}" = "webm" ]; then
            is_audio_only "$file"
            if [ $? -eq 0 ]; then
                echo "$file"
            fi
        fi
    done
}

# Usage: ./script.sh /path/to/directory
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/directory"
    exit 1
fi

find_audio_only_webms "$1"
