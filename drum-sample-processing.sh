for file in ./*.mp3
do 
    mv "$file" "${file/  //}"
done

trim-silence