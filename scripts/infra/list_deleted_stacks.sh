#!/bin/bash

# Set default output format and days
output_format="table"
days=90

# Function to display help message
show_help() {
    echo "Usage: $0 [-j|-c|-t] [-d days] [-p profile]"
    echo "Options:"
    echo "  -j    Output in JSON format"
    echo "  -c    Output in CSV format"
    echo "  -t    Output in table format (default)"
    echo "  -d    Number of days to look back (default: 90)"
    echo "  -p    AWS profile to use"
    echo "  -h    Show this help message"
}

# Process command line arguments
while getopts "jctd:p:h" opt; do
    case $opt in
        j) output_format="json" ;;
        c) output_format="csv" ;;
        t) output_format="table" ;;
        d) days="$OPTARG" ;;
        p) export AWS_PROFILE="$OPTARG" ;;
        h) show_help; exit 0 ;;
        ?) show_help; exit 1 ;;
    esac
done

# Calculate the date from X days ago in ISO 8601 format
start_date=$(date -u -d "$days days ago" +"%Y-%m-%dT%H:%M:%SZ")

# Create temporary files
temp_file=$(mktemp)
if [ "$output_format" = "csv" ]; then
    echo "Region,StackName,DeletionTime,StackStatus" > "$temp_file"
fi

# Get list of all regions
regions=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)

# Function to format date
format_date() {
    date -u -d "$1" "+%Y-%m-%d %H:%M:%S UTC"
}

# Counter for total stacks
total_stacks=0

# Process each region
for region in $regions; do
    echo "Checking region: $region" >&2
    
    # Get deleted stacks for the region
    deleted_stacks=$(aws cloudformation list-stacks \
        --region "$region" \
        --query "StackSummaries[?StackStatus=='DELETE_COMPLETE' && DeletionTime>='${start_date}'].[StackName,DeletionTime,StackStatus]" \
        --output json)
    
    # Skip if no deleted stacks found
    if [ "$deleted_stacks" == "[]" ]; then
        continue
    fi

    # Process the results based on output format
    if [ "$output_format" = "json" ]; then
        # Add region information to each stack
        modified_stacks=$(echo "$deleted_stacks" | jq --arg region "$region" \
            '[.[] | {Region: $region, StackName: .[0], DeletionTime: .[1], StackStatus: .[2]}]')
        if [ "$(cat "$temp_file")" = "" ]; then
            echo "$modified_stacks" > "$temp_file"
        else
            jq -s 'add' "$temp_file" <(echo "$modified_stacks") > "${temp_file}.tmp" && mv "${temp_file}.tmp" "$temp_file"
        fi
    elif [ "$output_format" = "csv" ]; then
        echo "$deleted_stacks" | jq -r '.[] | ["'"$region"'", .[0], .[1], .[2]] | @csv' >> "$temp_file"
    else
        # Table format
        echo "$deleted_stacks" | jq -r '.[] | ['"\"$region\""', .[0], .[1], .[2]] | @tsv' | \
            while IFS=$'\t' read -r region_name stack_name deletion_time status; do
                printf "%-15s %-50s %-25s %-15s\n" \
                    "$region_name" \
                    "$stack_name" \
                    "$(format_date "$deletion_time")" \
                    "$status"
            done >> "$temp_file"
    fi

    # Update total stacks count
    count=$(echo "$deleted_stacks" | jq length)
    total_stacks=$((total_stacks + count))
done

# Output results
if [ "$output_format" = "json" ]; then
    cat "$temp_file"
elif [ "$output_format" = "csv" ]; then
    cat "$temp_file"
else
    # Print header for table format
    printf "\n%-15s %-50s %-25s %-15s\n" "Region" "Stack Name" "Deletion Time" "Status"
    printf "%s\n" "───────────────────────────────────────────────────────────────────────────────────────────────────"
    cat "$temp_file"
    printf "%s\n" "───────────────────────────────────────────────────────────────────────────────────────────────────"
fi

# Print summary
echo -e "\nTotal deleted stacks found: $total_stacks" >&2
echo "Time period: Last $days days (since $(format_date "$start_date"))" >&2

# Cleanup
rm -f "$temp_file"
