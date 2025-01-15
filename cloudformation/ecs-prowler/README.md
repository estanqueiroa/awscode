
# Prowler Security Assessment CloudFormation Template

## Overview
This CloudFormation template automates AWS security best practices assessments using Prowler. It deploys a solution that:
- Runs Prowler in an ECS Fargate task
- Stores assessment results in an S3 bucket
- Logs output to CloudWatch Logs
- Executes daily security scans automatically

![Alt text](../diagrams/ecs-prowler.png?raw=true "Diagram Image")

## Prerequisites
- An existing VPC with internet access
- At least two public subnets
- AWS CLI configured with appropriate permissions

## Parameters
- `pVpcId`: VPC ID where resources will be deployed
- `pSubnetIds`: List of subnet IDs for task deployment
- `pImageRepositoryName`: Name for ECR repository (default: prowler-tool-ecr)
- `pDockerImage`: Choose between public or private Docker image

## Features
- Automated daily security scans
- S3 bucket with versioning and encryption
- CloudWatch Logs integration
- Supports both public and private container images
- 90-day retention policy for scan results

## Deployment

### Option 1: AWS Console
1. Navigate to CloudFormation
2. Create new stack
3. Upload template
4. Fill required parameters
5. Create stack

### Option 2: AWS CLI
```bash
aws cloudformation create-stack \
  --stack-name prowler-security-stack \
  --template-body file://template.yml \
  --parameters \
    ParameterKey=pVpcId,ParameterValue=vpc-xxxx \
    ParameterKey=pSubnetIds,ParameterValue=subnet-xxxx,subnet-yyyy \
  --capabilities CAPABILITY_IAM
```

### Option 3: RAIN

```bash
rain deploy prowler-ecs.yaml
```

## Important Notes
- If selecting private Docker image, manually run CodeBuild project after stack creation
- Prowler scans are scheduled to run daily at 1:00 AM UTC
- Results are stored in S3 with 90-day retention
- All S3 access is TLS-encrypted

## Resources Created
- ECS Cluster
- Fargate Task Definition
- IAM Roles and Policies
- S3 Bucket
- CloudWatch Logs Group
- EventBridge Rule
- ECR Repository (if private image selected)
- CodeBuild Project (if private image selected)

## Outputs
- Task Definition ARN
- S3 Bucket Name and ARN
- ECR Repository URI (if private)
- CodeBuild Project Name (if private)

## Security Features
- Enforced TLS for S3 access
- Private S3 bucket configuration
- Server-side encryption
- Least privilege IAM permissions

## Maintenance
- Monitor CloudWatch Logs for scan results
- Review S3 bucket for assessment reports
- Check EventBridge rule for scheduling changes if needed