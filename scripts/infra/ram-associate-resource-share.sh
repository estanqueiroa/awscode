# aws ram associate-resource-share

# Disclaimer: This script is provided as-is, without any warranty or support. Users are responsible for testing and implementing the script in their own environments.
#
#
# set of commands that interact with the AWS Resource Access Manager (RAM) service to add a new AWS account as a principal to an existing resource share
#

# !/bin/bash

# Set the necessary variables
RESOURCE_SHARE_NAME="my-resolver-rule-share"
NEW_ACCOUNT_ID="123456789012"
 
# Get the resource share ARN
RESOURCE_SHARE_ARN=$(aws ram get-resource-shares \
  --name $RESOURCE_SHARE_NAME \
  --resource-share-status ACTIVE \
  --query 'resourceShares[0].resourceShareArn' \
  --output text)
 
# Add the new account as a principal to the resource share
aws ram associate-resource-share \
  --resource-share-arn $RESOURCE_SHARE_ARN \
  --principals arn:aws:iam::$NEW_ACCOUNT_ID:root
 
# Verify the updated resource share
aws ram get-resource-share \
  --resource-share-arn $RESOURCE_SHARE_ARN \
  --query 'resourceShare.principals' \
  --output text