# AWS Bedrock FinOps Report Generator

This solution deploys an automated FinOps reporting system using AWS Bedrock, Lambda, SNS, and EventBridge.

Solution developed by: Rodrigo Guastalli [Linkedin](https://www.linkedin.com/in/rodrigoberentajguastalli/)

This CloudFormation template is in DRAFT version and may need minor adjustments to run the solution sucessfully. 
You can find the original Lambda code and IAM role permissions in the folder.

![Alt text](../diagrams/genai-finops.png?raw=true "Diagram Image")

## Prerequisites

1. AWS Bedrock Model Access must be enabled in your AWS Console
2. IAM permissions to create the required resources
3. Python 3.12 runtime support in your AWS region

## Solution Components

- AWS Lambda function (Python 3.12)
- Amazon S3 bucket for report storage
- Amazon SNS topic for notifications
- Amazon EventBridge rule for scheduling
- IAM roles and policies
- CloudWatch Logs group

## Deployment Instructions

1. First, ensure you have enabled Bedrock Model Access in your AWS Console

2. Create an IAM role in the Management Account (Payer) for the Assume Role (e.g. Name "FinOpsCeReadRole") - check `roles` folder for the JSON permissions FinOpsCeReadRole

3. Create TXT file with list of AWS Accounts including Account name and ID (e.g. each row 'Name,123456789012')

4. Deploy the CloudFormation template

5. Upload TXT file to S3 bucket

6. Execute Lambda function to test the report

# Parameters

* pSolutionName: Name prefix for the created resources
* pEmailAddress: Email address to receive the reports
* pScheduleEvent: Cron expression for report generation (default: Monday 10 AM GMT)
* pTransition: Days before S3 objects transition to IA storage class
* pRetention: CloudWatch Logs retention period in days
* pTagCentroCusto: Cost Center tag value

# Features

* Weekly and monthly FinOps reports
* Cost analysis using AWS Cost Explorer
* AI-powered insights using Amazon Bedrock
* Budget tracking and anomaly detection
* Email notifications with report links
* S3 lifecycle management
* Automated scheduling

# Security Features

* S3 bucket with encryption and public access blocking
* IAM role with least privilege permissions
* SNS topic for secure notification delivery
* CloudWatch Logs for monitoring and debugging

# Output
The stack provides three main outputs:

* oLambdaFunction: ARN of the deployed Lambda function
* oSnsTopic: ARN of the SNS topic for notifications
* oAthenaBucket: S3 Output Bucket

# Cleanup

* Delete all files from S3 bucket (run `Empty` to delete all versions)
* Delete CloudFormation stack from Linked Account
* Delete IAM Role (assume-role by Lambda) from Payer Account

# License

This template is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.