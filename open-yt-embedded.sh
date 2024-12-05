#!/bin/bash

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

# Create a temporary file
temp_file=$(mktemp)
mv "$temp_file" "$temp_file.html"
temp_file="$temp_file.html"
trap 'rm -f "$temp_file"' EXIT

cat > "$temp_file" << EOF
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
            allow="encrypted-media; fullscreen"
            allowfullscreen>
        </iframe>
    </div>
</body>
</html>
EOF

# open the html file in the default browser
open "$temp_file"

# Wait a moment to ensure the browser has time to open the file
sleep 1
