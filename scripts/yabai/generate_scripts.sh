#!/bin/bash

TEMPLATE="focus_template.sh"
CSV_FILE="focus_queries.csv"
BASE_OUTPUT_DIR="../../builds/yabai"

# Create output directory if it doesn't exist
mkdir -p $BASE_OUTPUT_DIR

# Generate scripts for focus queries
while IFS=, read -r name condition title; do
    # Skip the header line
    if [ "$condition" == "select_contidion" ]; then
        continue
    fi

    # Create output directory
    output_dir="${BASE_OUTPUT_DIR}/focus"
    mkdir -p $output_dir

    # Generate a script name
    script_name="${output_dir}/${name}.sh"
    
    # Create the script by replacing placeholders in the template
    sed "s|{SELECT_CONDITION}|$condition|g; s|{TITLE}|$title|g" $TEMPLATE > $script_name
    
    # Make the script executable
    chmod +x $script_name
    
    echo "Generated script: $script_name"
done < $CSV_FILE
