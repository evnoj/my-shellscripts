# processes tracks exported from ableton that have a ' ' prepended to their name

for file in ./*.wav
do 
    mv "$file" "${file/  //}"
done

trim-silence