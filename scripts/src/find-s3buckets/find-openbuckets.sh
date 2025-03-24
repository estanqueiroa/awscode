# From this article: https://levelup.gitconnected.com/i-scraped-an-open-s3-bucket-for-a-week-here-is-what-i-found-9735f836b726

# Script to find random S3 buckets with open public access

#!/bin/bash

buckets=(
    "my-bucket"
    "test-bucket"
    "default-bucket"
    "new-bucket"
    "backup-data"
    "dev-assets"
    "production-static"
    "staging-files"
    "website-images"
    "app-backups"
    "client-uploads"
    "backup-database"
    "admin-files"
    "my-bucket-name"
    "your-bucket-name"
    "report-output"
    "report-files"
    "confidential-data"
)

total_buckets=${#buckets[@]}
open_buckets=0
remaining_buckets=$total_buckets

echo "Starting scan of $total_buckets buckets"
echo "----------------------------------------"

# Loop through each bucket and attempt to list its contents
for bucket in "${buckets[@]}"; do
    echo "Checking bucket: $bucket (Remaining: $remaining_buckets)"
    aws s3 ls "s3://$bucket" --no-sign-request 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "[+] Bucket FOUND and ACCESSIBLE: $bucket"
        ((open_buckets++))
    else
        echo "[-] Bucket not accessible: $bucket"
    fi
    
    ((remaining_buckets--))
    echo "----------------------------------------"
done

echo "SCAN COMPLETE"
echo "Total buckets checked: $total_buckets"
echo "Open buckets found: $open_buckets"

if [ $open_buckets -gt 0 ]; then
    echo "########################################################"
    echo "**IMPORTANT** If you have found an OPEN bucket"
    echo "Please check README for instructions on how to report it to AWS Support team"
    echo "########################################################"
fi
