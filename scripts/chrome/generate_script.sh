#!/bin/bash

# Base directory for Chrome profiles
base_path="$HOME/Library/Application Support/Google/Chrome"

# File containing the target email/user ID
user_email_file="target_email.txt"

# Output file path
output_dir="../../builds/chrome"
output_file="$output_dir/open_profile.sh"

# Template file path
template_file="template.sh"

# Check if the target email file exists
if [ ! -f "$user_email_file" ]; then
    echo "Error: $user_email_file not found."
    exit 1
fi

# Read the user email from the file
target_email=$(cat "$user_email_file")

find_chrome_profile() {
    for profile in "$base_path"/Profile\ *; do
        if [ -d "$profile" ]; then
            preferences_path="$profile/Preferences"
            if [ -f "$preferences_path" ]; then
                email=$(grep -o '"email":"[^"]*"' "$preferences_path" | cut -d '"' -f 4)
                if [[ "$email" == "$target_email" ]]; then
                    echo "$(basename "$profile")"
                    return
                fi
            fi
        fi
    done
    echo ""
}

# Find the profile
profile=$(find_chrome_profile)

if [ -z "$profile" ]; then
    echo "No profile owned by '$target_email' was found."
    exit 1
else
    echo "The profile owned by '$target_email' is: $profile"
fi

# Check if the template file exists
if [ ! -f "$template_file" ]; then
    echo "Error: $template_file not found."
    exit 1
fi

# Create the output directory if it doesn't exist
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# Read the template file and replace {PROFILE} with the found profile
sed "s/{PROFILE}/$profile/g" "$template_file" > "$output_file"

chmod +x "$output_file"

echo "The script has been generated at $output_file."
