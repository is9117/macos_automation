#!/bin/bash

export PATH="/opt/homebrew/bin:$PATH"

# Ensure yabai is running
if ! pgrep -x "yabai" > /dev/null
then
    echo "yabai is not running. Please start yabai first."
    exit 1
fi

# Get the IDs of all windows belonging to {SELECT_CONDITION}
window_ids=$(yabai -m query --windows | jq -r '.[] | select({SELECT_CONDITION}) | .id')

# Iterate over each window ID and check if the title contains {TITLE}
for id in $window_ids; do
    window_info=$(yabai -m query --windows --window $id)
    window_title=$(echo $window_info | jq -r '.title')
    
    if [[ $window_title == *"{TITLE}"* ]]; then
        echo "Focusing on window with ID: $id, Title: $window_title"
        yabai -m window --focus $id
        exit 0
    fi
done

echo "No window with title containing '{TITLE}' found."
