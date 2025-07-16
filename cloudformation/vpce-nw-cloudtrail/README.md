## Logging VPC Endpoints Network Activities Using CloudTrail

Reference: https://awstip.com/logging-vpc-endpoints-network-activities-using-cloudtrail-c75f82eae33c

## Architecture Overview

This template creates:

* A VPC with a public subnet and internet gateway
* Two EC2 instances with different IAM roles
* An S3 Gateway VPC endpoint with a policy that only allows access from EC2Role1
* A CloudTrail configuration with CloudWatch logs integration to monitor S3 activities
* Necessary IAM roles and policies
* Required S3 bucket for CloudTrail

## Deployment

To use this template:

* Deploy it in the us-east-1 region (or other AWS region)
* Wait for the stack creation to complete
* Connect to both EC2 instances using Systems Manager Session Manager
* Run the command `aws s3 ls --region us-east-1` on both instances
* Check CloudWatch logs group for the trail to see the successful and failed access attempts

Note: The instances are configured with Systems Manager access for secure connection without requiring public IP addresses or SSH access.

## Cleanup

* Delete the CFN stack created to remove all resources
* Delete the CloudWatch logs group
* Delete the S3 bucket for CloudTrail logs