# kill process by specifying the exact string to match the command
targetProcess="/Applications/MidiPipe.app/Contents/MacOS/MidiPipe"
processList=$(ps -axo pid,comm | grep "/Applications/MidiPipe.app/Contents/MacOS/MidiPipe")
while read -r line; do
    pid=$(echo "$line" | awk '{print $1}')
    comm=$(echo "$line" | awk '{$1=""; print $0}' | sed 's/^[[:space:]]*//')
    if [[ "$comm" == "$targetProcess" ]]; then
        echo "$pid"
    fi
done <<< "$processList"
