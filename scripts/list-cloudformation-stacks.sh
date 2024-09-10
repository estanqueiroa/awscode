# lists all CloudFormation stacks across all regions in your AWS account
#
# make it executable with the following command:

# chmod +x list-cloudformation-stacks.sh


#!/bin/bash

# Get a list of all available regions
regions=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)

# Iterate through each region and list the CloudFormation stacks
for region in $regions; do
    echo "Stacks in region: $region"
    aws cloudformation list-stacks --region "$region" --query 'StackSummaries[].StackName' --output table --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE
    echo "---------------------"
done