# processes tracks exported from ableton that have a ' ' prepended to their name

for file in ./*.wav
do 
    if ["${file:0:2}" -eq '  ']
        mv "$file" "${file/  //}"
    fi
done

trim-silence