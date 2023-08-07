for file in ./*.wav
do
    cp "$file" "${file%.wav}-temp.wav"
    # -ac 1 flag mixes stereo down to mono, or preserves mono to mono. to trim a stereo channel to stereo, change to '-ac 2'
    ffmpeg -y -i "${file%.wav}-temp.wav" -ac 1 -filter:a "volume=1.2" "$file" # volume=1.5 would make volume %150 of original, volume =.5 would make volume 50% of original
    rm "${file%.wav}-temp.wav"
done