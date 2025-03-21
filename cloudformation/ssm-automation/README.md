# SSM Automation Script Runner

## Overview
This CloudFormation template creates SSM Automation documents to run commands and execute scripts on both Linux and Windows EC2 instances. It includes automation for retrieving system information such as IP addresses, hostnames, and OS details.

## Prerequisites
- AWS Account with appropriate permissions
- EC2 instances with SSM Agent installed (Linux or Windows)
- Proper IAM roles and [SSM permissions](https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-instance-permissions.html) configured with attached policy **AmazonSSMManagedInstanceCore**

## Template Features

### 1. IAM Role Configuration
- Creates an optional IAM role for SSM Automation
- Uses existing role if specified
- Includes necessary permissions for SSM operations

### 2. Linux Automation Document
- Retrieves instance IP address and hostname
- Executes Python script to process the output
- Returns formatted results including:
  - Instance ID
  - IP Address
  - Hostname

### 3. Windows Automation Document
- Captures primary IP address
- Retrieves detailed OS information:
  - OS Name
  - Version
  - Build Number
  - Architecture

## Usage

### Deployment
Deploy the template using AWS CloudFormation:

```bash
aws cloudformation create-stack \
  --stack-name ssm-automation-scripts \
  --template-body file://template.yaml \
  --capabilities CAPABILITY_IAM
```

### Parameters

- ExistingRoleName (Optional): Specify an existing IAM role name. Leave blank to create a new role.

### Running the Automations

```bash
aws ssm start-automation-execution \
  --document-name <Linux or Windows-Document-Name> \
  --parameters "InstanceId=[EC2-INSTANCE-ID]"
```

## Outputs

- oRoleCreated: The IAM role created (if applicable)
- oLinuxAutomationDocument: Name of the Linux automation document
- oWindowsAutomationDocument: Name of the Windows automation document

## Cleanup

- Delete CloudFormation stack to remove all created resources

## References

[AWS Systems Manager Execute Script Examples](https://github.com/aws-samples/aws-systems-manager-executescript-slack/blob/main/EncryptedVolsToSlack.yaml)

[AWS SSM Document Language Service](https://github.com/aws/amazon-ssm-document-language-service/blob/master/src/schema/automation/actions/runCommand.ts)

## Important Notes

- This template may incur AWS costs
- Test in a non-production environment first
- Review and modify IAM permissions based on your security requirements