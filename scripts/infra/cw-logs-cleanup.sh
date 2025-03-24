# Script to delete CloudWatch log groups that haven't been updated (it checks log streams last event time) in the last 30 days using the AWS CLI

#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 [-e|--execute]"
    echo "  -e, --execute    Execute the deletion of old log streams and empty log groups"
    echo "  If no option is provided, a dry run will be performed by default."
    exit 1
}

# Parse command line options
EXECUTE=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -e|--execute) EXECUTE=true ;;
        -h|--help) usage ;;
        *) usage ;;
    esac
    shift
done

# Get the current date in seconds since epoch
current_date=$(date +%s)

# Calculate the date 30 days ago in seconds since epoch
thirty_days_ago=$((current_date - 30*24*60*60))

# Showing date threshold
date_time=$(date -d @$thirty_days_ago "+%Y-%m-%d %H:%M:%S")
echo "Checking threshold for date: $date_time"

# Function to delete or simulate deletion of log stream
delete_log_stream() {
    local log_group_name="$1"
    local stream_name="$2"
    if [ "$EXECUTE" = true ]; then
        echo "Deleting log stream: $stream_name from log group: $log_group_name"
        aws logs delete-log-stream --log-group-name "$log_group_name" --log-stream-name "$stream_name"
    else
        echo "[DRY RUN] Would delete log stream: $stream_name from log group: $log_group_name"
    fi
}

# Function to delete or simulate deletion of empty log group
delete_empty_log_group() {
    local log_group_name="$1"
    if [ "$EXECUTE" = true ]; then
        echo "Deleting empty log group: $log_group_name"
        aws logs delete-log-group --log-group-name "$log_group_name"
    else
        echo "[DRY RUN] Would delete empty log group: $log_group_name"
    fi
}

# Function to process log streams for a given log group
process_log_group() {
    local log_group_name="$1"
    local streams_to_delete=()
    local total_streams=0

    # Get current time in seconds since epoch
    local current_time=$(date +%s)
    # Calculate cutoff time (30 days ago)
    local cutoff_time=$((current_time - 30*24*60*60))

    # First, count total streams and identify streams to delete
    while IFS=$'\t' read -r last_event_timestamp stream_name; do
        ((total_streams++))
        
        # Convert last_event_timestamp from milliseconds to seconds
        last_event_seconds=$((last_event_timestamp / 1000))
        
        # Debug output
        # echo "Stream: $stream_name, Last Event: $(date -d @$last_event_seconds '+%Y-%m-%d %H:%M:%S')"
        
        echo "Processing logstream # $total_streams"

        if [ "$last_event_seconds" -lt "$cutoff_time" ]; then
            streams_to_delete+=("$stream_name")
            #echo "  [MARKED FOR DELETION]"
        # else
        #     echo "  [KEEPING]"
        fi
    done < <(aws logs describe-log-streams --log-group-name "$log_group_name" --order-by LastEventTime --descending --output text --query 'logStreams[*].[lastEventTimestamp,logStreamName]')

    # THIS IS OPTIONAL - TO DELETE LOG STREAMS
    # # Now delete the identified streams
    # for stream in "${streams_to_delete[@]}"; do
    #     delete_log_stream "$log_group_name" "$stream"
    # done

    local streams_deleted=${#streams_to_delete[@]}
    echo "Processed log group: $log_group_name - $streams_deleted out of $total_streams stream(s) to be deleted."

    # Check if the log group is empty before processing
    if [ $total_streams -eq 0 ]; then
        echo "Log group $log_group_name is already empty."
        delete_empty_log_group "$log_group_name"
        return 1  # Indicate that the group was deleted
    fi

    # Check if the log group is empty after processing
    if [ $streams_deleted -eq $total_streams ] && [ $total_streams -ne 0 ]; then
        delete_empty_log_group "$log_group_name"
        return 1  # Indicate that the group was deleted
    fi
    return 0  # Indicate that the group was not deleted
}

# Get all log groups
log_groups=$(aws logs describe-log-groups --query 'logGroups[*].logGroupName' --output text)

# Initialize counters
total_streams_to_delete=0
total_groups_processed=0
total_groups_to_delete=0

# Process each log group
for log_group in $log_groups; do
    ((total_groups_processed++))
    process_log_group "$log_group"
    if [ $? -eq 1 ]; then
        ((total_groups_to_delete++))
    fi
done

if [ "$EXECUTE" = true ]; then
    echo "Operation completed. Old log streams and empty log groups have been deleted."
else
    echo "Dry run completed. Old log streams and empty log groups would be deleted. Use -e or --execute to perform actual deletion."
fi

echo "Total log groups processed: $total_groups_processed"
echo "Log groups that would be deleted: $total_groups_to_delete"