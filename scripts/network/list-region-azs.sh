# This script lists all AWS regions and their corresponding availability zones, 
# providing a comprehensive overview of the AWS global infrastructure, 

#!/bin/bash

# Loop through all AWS regions
for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text); do
    # Print the current region name
    echo "Region: $region"
    
    # List all availability zones in the current region
    aws ec2 describe-availability-zones --region "$region" --query "AvailabilityZones[].ZoneName" --output text
    
    # Print an empty line for better readability
    echo ""
done