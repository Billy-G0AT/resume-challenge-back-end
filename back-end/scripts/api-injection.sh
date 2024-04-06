#!/bin/bash

# Capture New URL as Argument
new_url="$1"

# Path to JavaScript File
file="../../front-end/javascript/visitor-counter.js"

# Replace Old URL in JavaScript File
 sed -i "s#var apiUrl = \".*\"#var apiUrl = \"$new_url\"#" "$file"

# Grabs URL From JavaScript File
apiUrl=$(grep -oP 'apiUrl\s*=\s*"\K[^"]+' $file)

# Compares URL's
if [ "$apiUrl" == "$new_url" ]; then
    echo "New API URL has been successfully injected."
    exit 0
else
    echo "URL's are not the same" >&2
    echo "Old URL is $apiUrl" >&2
    echo "New URL is $new_url" >&2
    exit 1
fi
