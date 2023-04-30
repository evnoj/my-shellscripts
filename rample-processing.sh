# processes tracks for rample exported from ableton that have a '  ' prepended to their name

for file in ./*.wav
do 
    if [ "${file:0:2}" -eq '  ' ]
    then
        mv "$file" "${file/  //}"
    fi
done

rm ' .wav'

trim-silence