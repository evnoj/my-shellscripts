for file in ./*.wav
do
    cp "$file" "${file%.wav}-temp.wav"
    # -ac 1 flag mixes stereo down to mono, or preserves mono to mono. to trim a stereo channel to stereo, change to '-ac 2'
    ffmpeg -y -i "${file%.wav}-temp.wav" -ac 1 -af "areverse,silenceremove=start_periods=1:detection=peak:start_threshold=0.0001,aformat=dblp,areverse" "$file"
    rm "${file%.wav}-temp.wav"
done