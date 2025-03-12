# AWS EC2 and S3 Resource Tagging Automation

This CloudFormation template deploys a solution for automatically tagging AWS EC2 instances and S3 buckets using a Lambda function with [Tag Editor](https://us-east-1.console.aws.amazon.com/resource-groups/tag-editor/find-resources?region=us-east-1) coding. 
The solution applies standardized tags to help with resource management and cost allocation.
More info [here](https://docs.aws.amazon.com/tag-editor/latest/userguide/tagging.html) and [here](https://docs.aws.amazon.com/ARG/latest/userguide/resource-groups.html)

[Tags for cost allocation and financial management](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tags-for-cost-allocation-and-financial-management.html)


## Overview

The template creates:
- Lambda function to handle resource tagging
- IAM role with necessary permissions 
- CloudWatch Log Group for monitoring
- Custom resource to trigger the tagging process

## Prerequisites

- AWS CLI installed and configured
- Appropriate AWS permissions to create the resources
- Python 3.12 runtime support in your desired AWS region

## Quick Start

### Using AWS Console

1. Navigate to CloudFormation in AWS Console
2. Click "Create stack" and upload template file
3. Set parameter for KeyProject (default: CloudFormationDemo)
4. Review and create stack

## Tags Applied

The following tags are applied to EC2 instances and S3 buckets:

* Project: (Value from KeyProject parameter)
* LastTaggedBy: {StackName}-CloudFormation
* Environment: Production77
* Owner: TeamA77

## Technical Details

* Lambda Function
Runtime: Python 3.12
Architecture: ARM64 (Graviton)
Memory: 128MB
Timeout: 900 seconds (15 minutes)
Batch size: 20 resources per batch

* IAM Permissions
tag:GetResources
tag:TagResources
tag:UntagResources
s3:GetBucketTagging
s3:PutBucketTagging
ec2:CreateTags
ec2:Get*

* CloudWatch Logging

Log Group Name: check Stack Output

Retention: 14 days

## Monitoring & Troubleshooting

Monitor the Lambda execution in CloudWatch Logs for the Common Issues

* Permission errors - Check IAM role permissions

* Failed tagging operations - Check CloudWatch logs for specific failures

* Verify resource existence and accessibility

## Outputs

* LambdaFunctionArn	- ARN of created Lambda function
* LambdaFunctionName - Name of created Lambda function
* LogGroupName - Name of created Log Group

## Limitations

* Tags only EC2 instances and S3 buckets (you can modify Lambda code for more resource types)
* Resources must be in same region as Lambda
* Maximum 20 resources per batch
* 15 minute Lambda execution timeout
* No scheduled execution (you can add EventBridge rule to trigger Lambda on a scheduled basis)

* To tag additional resource types:

Add desired resource types in Lambda code:

```bash
# rds:db
# dynamodb:table
# lambda:function
# ecs:cluster
# eks:cluster
# iam:role
```

* Add corresponding IAM permissions to LambdaExecutionRole

## Security Considerations

* Uses principle of least privilege for IAM role
* Resources tagged with stack identification
* CloudWatch logs for audit trail
* AWS managed policy for Lambda execution


## Cost Considerations
* Lambda invocation costs (128MB)
* CloudWatch Logs storage
* API calls for resource tagging

## Cleaanup

* Delete the created CloudWatch log group
* Delete Cloudformation stack to remove all resources

## Contributing
Feel free to submit issues and enhancement requests!