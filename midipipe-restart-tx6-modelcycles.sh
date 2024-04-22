find-pid-by-cmd.sh '/Applications/MidiPipe.app/Contents/MacOS/MidiPipe' | xargs kill -s kill
open "/Users/evanjohnson/config/MidiPipe/tx6<->modelcycles.mipi"
sleep 2.4
hs -c 'hs.application.find("MidiPipe"):hide()'
