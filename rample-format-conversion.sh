!/usr/bin/env zsh

# get parameters. see obsidian:shell commands/get command-line args
stereo_tracks=''

print_usage() {
  printf "Usage: Converts all files in the directory to mono 16-bit 44.1 khz .wav files, deleting the pre-converted files.
  This will catch all files, and remove non-audio files.
  parameters:
    -s: Specifies a set of characters, and will not convert to mono files that start with one of these characters, the converted files will be stereo if the original files were stereo."
}

while getopts 's:' flag; do
  case "${flag}" in
    s) stereo_tracks="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

# rename the original files to know which ones to delete
for file in *; do
    mv "$file" "temp-$file"
done

# convert the files to 16-bit 44.1 khz wav files, mono by default stereo if specified
for file in *; do
    # Create the output filename by removing the 'temp-' prefix and replacing the extension with .wav
    output_file="${file#temp-}"
    output_file="${file%.*}.wav"

    # Convert the file to 16-bit 44.1khz mono .wav, unless the filename starts with a character specified in the 's' parameter, then leave the mono/stereo as is
    if [[${file:0:1} == *"$stereo_tracks"*]]
    then
        ffmpeg -i "$file" -ar 44100 -sample_fmt s16 "$output_file"
    else
        ffmpeg -i "$file" -ac 1 -ar 44100 -sample_fmt s16 "$output_file"
    fi

    # remove the original file
    rm $file
done