#!/bin/bash

# returned RGB values range from 0-255
osascript -l JavaScript -s o -e "
    const app = Application.currentApplication();
    app.includeStandardAdditions = true;
    const rgb = app.chooseColor({defaultColor: [0.5, 0.5, 0.5]})
        .map(n => Math.round(n * 255))
        .join(\", \");
    \`rgb(\${rgb})\`;
" 2>/dev/null
