inboxdir=$HOME/tunes/inbox
for zip in $inboxdir/zipped/*.zip; do
    # unzip "$zip" -d $inboxdir/unzipped
    name=${zip%.zip}
    name=$(basename "$name")
    mkdir "$inboxdir/unzipped/$name"
done

    
