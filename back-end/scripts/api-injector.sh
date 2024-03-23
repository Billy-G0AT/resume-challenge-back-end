#!/bin/bash

# Go to Terrafrom dir
cd ../infra

# Capture Terraform Output
new_url=$(terraform output -raw api_url)
# new_url=$(terraform output -raw api_url)

# Path to JavaScript file
file="../../front-end/javascript/visitor-counter.js"

# Replace old URL with new URL
sed -i "s#var apiUrl = \".*\"#var apiUrl = \"$new_url\"#" "$file"

echo "Your API URL has been updated."
