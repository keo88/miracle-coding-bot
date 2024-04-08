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
    # Extract the file extension
    extension="${file##*.}"
    # Convert the extension to lowercase
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')

    # Map file extensions to programming languages
    case "$extension" in
        "py") language="python" ;;
        "js") language="javascript" ;;
        "java") language="java" ;;
        "cpp") language="cpp" ;;
        # Add more cases for other file extensions and corresponding languages as needed
        *) language="text" ;;  # Default to "text" for unsupported file types
    esac
    file_contents+="
language: $language

code:
\`\`\`$language
# $file

$content
\`\`\`
"
done <<< "$modified_files"

url="$1"

# Format the information
message="url: $url
$file_contents"
echo "$message"
# Return to the original directory
cd "$current_dir" || { echo "Failed to change directory back to $current_dir"; exit 1; }

# Send message to Discord using your Python script
python main.py "$message"
