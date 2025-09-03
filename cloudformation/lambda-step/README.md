# Multi-Language Greeting State Machine

This CloudFormation template deploys a language-based greeting system using AWS Step Functions, Lambda, and SNS.

## Overview

The system sends greeting messages in either English or Portuguese based on a language parameter, delivering the message to a specified email address through SNS.
Thats a simple demonstration on how to integrate Lambda functions with Step Functions state machine.

## Architecture Components

- **AWS Step Functions**: Orchestrates the workflow
- **AWS Lambda**: Contains greeting functions in English and Portuguese
- **Amazon SNS**: Handles email notifications
- **IAM Roles**: Manages necessary permissions

## Prerequisites

- AWS CLI configured with appropriate permissions
- Valid email address for notifications

## Deployment Parameters

1. **EmailAddress** (Required)
   - Your email address to receive notifications

2. **Language** (Required)
   - Options: 'en' (English) or 'pt' (Portuguese)
   - Default: 'en'

## Deployment Steps

1. Deploy the CloudFormation stack:
```bash
aws cloudformation create-stack \
  --stack-name greeting-state-machine \
  --template-body file://template.yaml \
  --parameters \
    ParameterKey=EmailAddress,ParameterValue=your.email@example.com \
    ParameterKey=Language,ParameterValue=en
```

2. Confirm the SNS subscription in your email

## Usage

Execute the state machine with an empty JSON input:
```json
{}
```

The system will:
1. Use the language specified during stack creation
2. Generate appropriate greeting
3. Send notification to the registered email

## Outputs

- `StateMachineArn`: ARN of the created state machine
- `SNSTopicArn`: ARN of the SNS topic
- `SelectedLanguage`: Configured language setting

## Notes

- To change the language, update the stack with a new language parameter
- The system uses Python 3.9 for Lambda functions
- All necessary IAM roles and policies are automatically created

## Security

- Minimal IAM permissions following least privilege principle
- SNS topic limited to email protocol
- Lambda functions restricted to basic execution and SNS publishing