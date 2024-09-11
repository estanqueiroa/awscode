#
# Bash script that lists the largest folders in a given directory
#

#!/bin/bash

# Set the directory to analyze
dir_to_analyze="/path/to/directory/"

# Set the number of folders to display
num_folders=10

# Change to the directory to analyze
if ! cd "$dir_to_analyze"; then
    echo "Error: Could not change to directory '$dir_to_analyze'" >&2
    exit 1
fi

# Print the header
echo
echo "Top $num_folders largest folders in $dir_to_analyze:"
echo "----------------------------------------------------"

du -sh * | sort -hr | head -n $num_folders