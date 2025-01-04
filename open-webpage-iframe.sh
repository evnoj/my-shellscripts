#!/bin/bash

# opens a webpage in an iframe to get around the Cold Turkey Blocker
# pass the webpage's URL as the sole argument to the script
# intended to be able to access reddit/HN pages that appear in search results
#
# requirements:
# macOS
# Python 3
# wget

set -euo pipefail
exec >/dev/null 2>&1 # suppress all output
shopt -s extglob

# Check if a URL was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <youtube-url>"
    exit 1
fi
# change reddit to old reddit
url="${1/www.reddit/old.reddit}"

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT
cd "$temp_dir"
wget -EHkKp "$url"
python3 -m http.server &
server_pid=$!

temp_file=$(mktemp)
mv "$temp_file" "$temp_file.html"
temp_file="$temp_file.html"
trap 'rm -f "$temp_file"' EXIT

cat > "$temp_file" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Full Window iFrame</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            overflow: hidden; /* Prevent scrolling */
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
    <iframe src="http://localhost:8000${url#http?(s):}index.html"></iframe>
</body>
</html>
EOF

open "$temp_file"
sleep 2
kill "$server_pid" > /dev/null 2>&1
