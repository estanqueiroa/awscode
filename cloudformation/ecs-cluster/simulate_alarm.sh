# Accept an alarm name as input
# Put the alarm in the ALARM state
# Wait for user input
# Return the alarm to the OK state

#!/bin/bash

# Check if an alarm name was provided
if [ $# -eq 0 ]; then
    echo "Please provide an alarm name."
    echo "Usage: $0 <alarm-name>"
    exit 1
fi

ALARM_NAME="$1"

# Function to check if the AWS CLI is installed
check_aws_cli() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it and configure your credentials."
        exit 1
    fi
}

# Function to set alarm state
set_alarm_state() {
    local state="$1"
    local reason="$2"
    
    aws cloudwatch set-alarm-state \
        --alarm-name "$ALARM_NAME" \
        --state-value "$state" \
        --state-reason "$reason"
    
    if [ $? -eq 0 ]; then
        echo "Alarm '$ALARM_NAME' set to $state state."
    else
        echo "Failed to set alarm state. Please check your permissions and alarm name."
        exit 1
    fi
}

# Main script
check_aws_cli

echo "Setting alarm '$ALARM_NAME' to ALARM state..."
set_alarm_state "ALARM" "Simulating alarm state for testing"

echo "Alarm is now in ALARM state. Press Enter to return it to OK state..."
read

echo "Setting alarm '$ALARM_NAME' back to OK state..."
set_alarm_state "OK" "Ending simulation, returning to normal state"

echo "Script completed."
