# S3 Storage Size Monitor using Lambda function(s)

![Alt text](../diagrams/s3-monitor.png?raw=true "Diagram Image")

## This CloudFormation template creates:

* An S3 bucket to monitor
* An SNS topic for email notifications
* An email subscription for the SNS topic

* A Lambda function that:
- Lists all objects in the bucket
- Calculates total size and file count
- Identifies all folders
- Sends a formatted report via SNS

* Required IAM roles and permissions
* An EventBridge rule to trigger the Lambda function weekly
* Step function state machine to process all buckets using Lambda and send SNS


## To use this template:

* Deploy the template using AWS CloudFormation
* Subscribe to the SNS topic and confirm the acceptance that will be sent to your email

## The weekly report will include:

* Total number of files
* Total size of all files in GB
* List of all folders in the bucket

You can modify the schedule expression in WeeklyTriggerRule to change the frequency of the reports. The current setting is rate(7 days), but you can adjust it according to your needs.

# Step function

The state machine flow is:

* List all buckets and create report putput
* Process output and send SNS topic notifications

# Limitations

* Single Bucket: large buckets may not be processed successfully due to Lambda timeout settings (max. 15 minutes)
* Lambda layer configured for us-east-1 region, you can find another layers regions [here](https://github.com/keithrozario/Klayers/tree/master/deployments/python3.12-arm64) 
* Needs better formating for email message (json dump)

