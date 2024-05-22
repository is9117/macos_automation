#!/bin/bash

TEMPLATE="template.sh"
URLS_FILE="urls.csv"
BROWSERS_FILE="browsers.txt"
BASE_OUTPUT_DIR="../../builds/browser"

# Create output directory if it doesn't exist
mkdir -p $BASE_OUTPUT_DIR

# Read URLs and Browsers
BROWSERS=()
while IFS= read -r line; do
    BROWSERS+=("$line")
done < $BROWSERS_FILE

# Generate scripts for each browser and URL combination
while IFS=, read -r filename url; do
    # Skip the header line
    if [ "$filename" == "filename" ]; then
        continue
    fi

    for browser in "${BROWSERS[@]}"; do
        # Create browser-specific output directory
        browser_output_dir="${BASE_OUTPUT_DIR}/${browser// /_}"
        mkdir -p $browser_output_dir

        # Generate a script filename
        script_name="${browser_output_dir}/open_${filename}.sh"
        
        # Create the script by replacing placeholders in the template
        sed "s|{browser}|$browser|g; s|{url}|$url|g" $TEMPLATE > $script_name
        
        # Make the script executable
        chmod +x $script_name
        
        echo "Generated script: $script_name"
    done
done < $URLS_FILE
