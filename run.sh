#!/bin/bash

# Source the .env file to load environment variables
source .env

# Store the current directory
current_dir=$(pwd)

# Change directory to the Git repository
cd "$REPO_PATH" || { echo "Failed to change directory to $REPO_PATH"; exit 1; }

# Get the latest commit message
commit_message=$(git log -1 --pretty=%B)

# Get the list of files modified in the latest commit
modified_files=$(git diff --name-only HEAD~1 HEAD)

# Initialize variable to store file contents
file_contents=""

echo "$commit_message"
echo "$modified_files"

while IFS= read -r file; do
    # Read the content of the file
    content=$(cat "$file")
    # Append file content to the variable
    file_contents+="
# $file

$content
"
done <<< "$modified_files"

url="$1"

# Prompt the user to enter the language
#read -p "Enter the language: " language
language="python"

# Format the information
message="url: $url

language: $language

code:
\`\`\`$language
$file_contents
\`\`\`"
echo "$message"
# Return to the original directory
cd "$current_dir" || { echo "Failed to change directory back to $current_dir"; exit 1; }

# Send message to Discord using your Python script
python main.py "$message"
