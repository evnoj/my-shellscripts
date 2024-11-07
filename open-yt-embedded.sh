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
echo "$temp_file"
trap 'rm -f "$temp_file"' EXIT

cat > "$temp_file" << EOF
<!DOCTYPE html>
<html>
<body>
    <iframe width="690" height="388"
        src="$url"
        frameborder="0"
        allow="encrypted-media"
        allowfullscreen>
    </iframe>
</body>
</html>
EOF

# open the html file in the default browser
open "$temp_file"

# Wait a moment to ensure the browser has time to open the file
sleep 1

