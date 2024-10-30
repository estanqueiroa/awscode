# This script provides a way to retrieve the PasswordLastUsed value, 
# the list of access keys, and the AccessKeyLastUsed value for each IAM user in your AWS environment.

#!/bin/bash

# Function to get the password last used date for a user
get_password_last_used() {
  local username=$1
  local password_last_used=$(aws iam get-user --user-name "$username" | jq -r '.User.PasswordLastUsed')
  echo "$password_last_used"
}

# Function to get the access key last used date for an access key
get_access_key_last_used() {
  local username=$1
  local access_key_id=$2
  local access_key_last_used=$(aws iam get-access-key-last-used --access-key-id "$access_key_id" | jq -r '.AccessKeyLastUsed.LastUsedDate')
  echo "$access_key_last_used"
}

# Function to list all access keys for a user
list_access_keys() {
  local username=$1
  local access_keys=$(aws iam list-access-keys --user-name "$username" | jq -r '.AccessKeyMetadata[].AccessKeyId')
  echo "$access_keys"
}

# Main script
aws iam list-users | jq -r '.Users[].UserName' | while read username; do
  password_last_used=$(get_password_last_used "$username")
  echo "User: $username, Password Last Used: $password_last_used"

  access_keys=$(list_access_keys "$username")
  for access_key in $access_keys; do
    access_key_last_used=$(get_access_key_last_used "$username" "$access_key")
    echo "  Access Key: $access_key, Last Used: $access_key_last_used"
  done
done
