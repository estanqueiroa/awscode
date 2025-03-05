#####################
#  script to show EC2 instance status
#####################

#!/bin/bash


# Function to get all AWS regions
get_regions() {
    aws ec2 describe-regions --query 'Regions[].RegionName' --output text
}

# Function to display menu and get region choice
select_region() {
    echo "Please select an option:"
    echo "1. List instances in all regions"
    echo "2. Select a specific region"
    echo "3. Exit"
    read -p "Enter your choice (1-3): " choice

    case $choice in
        1)
            list_all_regions
            ;;
        2)
            select_specific_region
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            select_region
            ;;
    esac
}

# Function to list instances in all regions
list_all_regions() {
    for region in $(get_regions); do
        echo -e "\nRegion: $region"
        echo "----------------------------------------"
        list_instances $region
    done
}


# Function to select a specific region
select_specific_region() {
    echo "Available regions:"
    regions=($(get_regions))
    select region in "${regions[@]}" "Go back"; do
        if [[ $region == "Go back" ]]; then
            select_region
            return
        elif [[ -n $region ]]; then
            echo -e "\nRegion: $region"
            echo "----------------------------------------"
            list_instances $region
            return
        else
            echo "Invalid selection. Please try again."
        fi
    done
}

# Function to list instances in a specific region
list_instances() {
    local region=$1

    echo "EC2 Instance Status:"
    echo "----------------------------------------"

    # Check if there are any instances in the region
    local instance_count=$(aws ec2 describe-instances --region $region --query 'Reservations[*].Instances[*].[InstanceId]' --output text | wc -w)

    if [ "$instance_count" -eq 0 ]; then
        echo "No instances found in $region"
    else

        # Get instance information and format output
        aws ec2 describe-instances --region $region --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,VpcId,Tags[?Key==`Name`].Value | [0],PrivateIpAddress,PublicIpAddress]' --output table 2>/dev/null || echo "No instances found in $region"

    fi
}

# Main script
echo "AWS EC2 Instance Status Checker"
echo "==============================="
select_region