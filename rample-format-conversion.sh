#!/usr/bin/env zsh

# rename the original files to know which ones to delete
for file in *; do
    mv "$file" "temp-$file"
done

# convert the files to 16-bit 44.1 khz wav files, mono by default stereo if specified
for file in *; do
    # Create the output filename by removing the 'temp-' prefix and replacing the extension with .wav
    output_file="${file#temp-}"
    output_file="${file%.*}.wav"

    # Convert the file to 16-bit 44.1khz mono .wav
    ffmpeg -i "$file" -ac 1 -ar 44100 -sample_fmt s16 "$output_file"

    # remove the original file
    rm $file
done