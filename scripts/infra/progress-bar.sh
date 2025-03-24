# simple Bash script to create an ASCII progress bar

#!/bin/bash

# Function to draw the progress bar
draw_progress_bar() {
    local percent=$1
    local width=50
    local num_filled=$((percent * width / 100))
    local num_empty=$((width - num_filled))

    printf "\rProgress: ["
    printf "%${num_filled}s" | tr ' ' '#'
    printf "%${num_empty}s" | tr ' ' ' '
    printf "] %3d%%" "$percent"
}

# Example usage
for i in {0..100}; do
    draw_progress_bar $i
    sleep 0.1  # Simulate some work being done
done

echo  # Move to the next line after completion