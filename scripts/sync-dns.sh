# Bash script to export DNS records from a Route 53 zone and import them into another zone (same zone names split-view DNS)
#
# https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zone-private-considerations.html#hosted-zone-private-considerations-split-view-dns
#
# This script will use the AWS CLI, so make sure you have it installed and configured with the necessary permissions.

#!/bin/bash

# Set variables
SOURCE_ZONE_ID="Z05775532DAP07N9AA0P0"
DESTINATION_ZONE_ID="Z053004527S1LP3LOMTRY"
TEMP_FILE="/tmp/route53_records.json"
DEST_RECORDS_FILE="/tmp/destination_records.json"
DRY_RUN=true  # Set dry run to true by default

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --execute) DRY_RUN=false ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Export records from source zone
aws route53 list-resource-record-sets --hosted-zone-id $SOURCE_ZONE_ID > $TEMP_FILE

# Export existing records from destination zone
aws route53 list-resource-record-sets --hosted-zone-id $DESTINATION_ZONE_ID > $DEST_RECORDS_FILE

# Process the exported records, filter out existing ones, and create the change batch JSON
jq -c --slurpfile dest $DEST_RECORDS_FILE '
    .ResourceRecordSets[] | 
    select(.Type != "NS" and .Type != "SOA") |
    select(.Name as $name | .Type as $type | 
           $dest[0].ResourceRecordSets | 
           map(select(.Name == $name and .Type == $type)) | 
           length == 0) |
    {Action: "CREATE", ResourceRecordSet: .}
' $TEMP_FILE | jq -s '{"Changes": .}' > /tmp/final_changes.json

# Check if there are any changes to apply
CHANGES_COUNT=$(jq '.Changes | length' /tmp/final_changes.json)

if [ "$CHANGES_COUNT" -eq "0" ]; then
    echo "No new records to add. All records already exist in the destination zone."
else
    echo "Found $CHANGES_COUNT new records to add."
    
    if $DRY_RUN; then
        echo "Dry run: The following records would be added: run script with --execute to create records"
        jq '.Changes[].ResourceRecordSet | {Name, Type, TTL, ResourceRecords}' /tmp/final_changes.json
    else
        echo "Executing changes..."
        # Import records to destination zone
        aws route53 change-resource-record-sets --hosted-zone-id $DESTINATION_ZONE_ID --change-batch file:///tmp/final_changes.json
        echo "New DNS records have been imported successfully."
    fi
fi

# Clean up temporary files
rm $TEMP_FILE $DEST_RECORDS_FILE /tmp/final_changes.json

echo "DNS record transfer process completed."


