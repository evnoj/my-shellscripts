find-pid-by-cmd.sh '/Applications/MidiPipe.app/Contents/MacOS/MidiPipe' | xargs kill -s kill

# hammerspoon waits for the window to open then hiddes it
hs ~/.hammerspoon/scripts/HideOrWait.lua
