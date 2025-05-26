# Bedrock Prompt Management with AWS CloudFormation

This CloudFormation template deploys a solution for managing Amazon Bedrock prompts using Lambda as a Custom Resource.

## Prerequisites

Before deploying this template, ensure you have:

1. AWS CLI installed and configured
2. Access to AWS Bedrock service
3. **Important**: Enable the Bedrock Model Id in AWS Console before deployment
4. Appropriate IAM permissions to create resources

## Architecture

The template creates the following resources:
- Lambda function (Python 3.13, ARM64)
- IAM Role with Bedrock permissions
- Custom Resource for Bedrock Prompt management
- SSM parameter for Prompt id
- Bedrock Prompt

## Parameters

| Parameter | Description | Default |
|-----------|-------------|----------|
| pModelId | Bedrock Model Id | amazon.titan-text-express-v1 |
| pTagCentroCusto | Cost Center Tag | CC012345 |

## Supported Bedrock Models

- amazon.titan-text-express-v1
- anthropic.claude-3-7-sonnet-20250219-v1:0

## Deployment

### Using AWS Console

1. Navigate to CloudFormation in AWS Console
2. Click "Create Stack"
3. Upload the template file
4. Fill in the parameters
5. Review and create the stack
6. After stack deployment, test the prompt version

**Update:**

Console creation of [prompt version](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management-version-create.html) is no longer required.
It will be created by the Lambda function.

## Template Features
* Custom resource for Bedrock prompt management
* Graviton (ARM64) Lambda for cost optimization
* Comprehensive IAM permissions
* Resource tagging for cost tracking
* Error handling and logging
* Support for multiple Bedrock models

## Notes
* Ensure Bedrock model access is enabled in your AWS account
* Check Lambda function logs for troubleshooting
* Review IAM permissions if deployment fails
* Monitor costs associated with Bedrock usage

## Clean Up
To remove all resources, delete the CloudFormation stack

The Bedrock prompt created will be deleted as part of the Lambda execution (Delete Event)

## Contributing
Please submit issues and pull requests for any improvements.

## License
This project is licensed under the MIT License - see the LICENSE file for details.