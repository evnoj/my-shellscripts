#!/bin/bash

# old approach of simply opening an HTML file stopped working, seems youtube starting blocking embeds in local files
# so I'm serving it over http from a local python http.server
# if throwing errors, check for running process with `ps -ef | rg "Python"`
# kill with `pkill -f "Python -m http.server"`
# check what's using the port with `lsof -i :8765`

# Check if a URL was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <youtube-url>"
    exit 1
fi

# Get the URL from command line argument
url=$1
id="${url#*v=}"      # Remove everything before "v="
id="${id%%&*}"       # Remove everything after "&" if present
url="https://www.youtube.com/embed/$id"

# Create a temporary directory
temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT

cat > "$temp_dir/index.html" << EOF
<!DOCTYPE html>
<html>
<head>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
        }
        .video-container {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }
    </style>
</head>
<body>
    <div class="video-container">
        <iframe
            src="$url"
            allow="autoplay; encrypted-media; fullscreen"
            allowfullscreen>
        </iframe>
    </div>
</body>
</html>
EOF

# Start a simple HTTP server in the background
cd "$temp_dir"
python3 -m http.server 8765 &
server_pid=$!

# Wait a moment for server to start
sleep 1

# Open the page in the default browser
open "http://localhost:8765/index.html"

# echo "Press Enter to stop the server and exit..."
# read

sleep 2
# Kill the server
kill $server_pid
