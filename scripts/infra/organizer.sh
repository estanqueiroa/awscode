#!/bin/bash
# filepath: organizer.sh

# Script to organize files by extension into folders, supporting multiple suffixes per folder

# Directory to organize (default: ~/Downloads)
DIR=$HOME/Downloads

# Define folders and their extensions (using indexed arrays for compatibility)
folders=("pictures" "documents" "videos" "downloads" "code")
pictures_ext=("jpg" "jpeg" "png")
documents_ext=("pdf" "txt" "doc" "csv")
videos_ext=("mp4" "avi" "mkv")
downloads_ext=("zip" "dmg" "exe" "tar" "gz")
code_ext=("py" "js" "html" "css" "json" "sh" "yaml" "yml" "xml")

# Create folders
for folder in "${folders[@]}"; do
    mkdir -p "$DIR/$folder"
done

# Function to check if extension matches any in the list
matches_ext() {
    local ext="$1"
    shift
    local exts=("$@")
    for e in "${exts[@]}"; do
        if [[ "$ext" == "$e" ]]; then
            return 0
        fi
    done
    return 1
}

# Move files
for file in "$DIR"/*; do
    if [[ -f "$file" ]]; then
        # Get extension and convert to lowercase
        extension="${file##*.}"
        extension_lower=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
        
        # Check which folder it belongs to
        if matches_ext "$extension_lower" "${pictures_ext[@]}"; then
            mv "$file" "$DIR/pictures/"
        elif matches_ext "$extension_lower" "${documents_ext[@]}"; then
            mv "$file" "$DIR/documents/"
        elif matches_ext "$extension_lower" "${videos_ext[@]}"; then
            mv "$file" "$DIR/videos/"
        elif matches_ext "$extension_lower" "${downloads_ext[@]}"; then
            mv "$file" "$DIR/downloads/"
        elif matches_ext "$extension_lower" "${code_ext[@]}"; then
            mv "$file" "$DIR/code/"
        fi
    fi
done

echo "Files organized."