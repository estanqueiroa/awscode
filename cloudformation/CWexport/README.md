# AWS CloudFormation Template: Automate CloudWatch Logs Export to S3

This CloudFormation template automates the process of exporting CloudWatch Logs to an Amazon S3 bucket on a regular schedule using AWS Lambda and Amazon EventBridge (formerly CloudWatch Events).

Reference: https://dev.to/rasankhalsa/automate-cloudwatch-logs-export-to-s3-using-lambda-and-event-bridge-2mdd

![Alt text](architecture.png?raw=true "Diagram Image")

## Description

The template creates the following resources:

* S3 Bucket: An S3 bucket to store the exported CloudWatch Logs. The bucket is configured with versioning, public access blocking, and a lifecycle policy to delete old versions after 90 days.

* S3 Bucket Policy: A bucket policy that grants the CloudWatch Logs service the necessary permissions to write logs to the S3 bucket.

* IAM Role: An IAM role that grants the necessary permissions for the Lambda function to create and manage CloudWatch Logs export tasks, as well as access the S3 bucket.

* Lambda Function: A Lambda function that is responsible for creating the CloudWatch Logs export tasks. The function is triggered by an Amazon EventBridge rule on a scheduled interval.

* Amazon EventBridge Rule: An EventBridge rule that triggers the Lambda function on a regular schedule (configurable through a parameter).

## Parameters

The template accepts the following parameters:

* pLogGroup: The name of the CloudWatch Logs group to export.
* pS3BucketPrefix: The prefix for the exported logs in the S3 bucket.
* pDistributionFrequency: The frequency (in minutes) at which the logs will be exported to the S3 bucket.

## Outputs

The template provides the following output:

* BucketName: The name of the S3 bucket where the exported logs are stored.

## Usage

* Download the CloudFormation template.
* Create a new CloudFormation stack using the template.
* Provide the required parameter values.
* Deploy the stack.

Once the stack is deployed, the Lambda function will be triggered at the specified interval, and the CloudWatch Logs will be exported to the configured S3 bucket.