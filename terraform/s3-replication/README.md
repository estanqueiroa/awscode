# S3 Replication with Terraform

Terraform infrastructure for setting up S3 bucket replication with automated cleanup capabilities.

## Overview

This project creates:
- Source and replica S3 buckets with versioning enabled
- S3 replication configuration to replicate all objects from source to replica
- Lambda function to empty both buckets (useful for cleanup before destruction)
- IAM roles and policies for replication and Lambda execution

## Architecture

```
Source Bucket → Replication → Replica Bucket
     ↓                            ↓
     └────── Lambda Function ─────┘
             (Empty Buckets)
```

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- Python 3.12 (for Lambda function)

## Resources Created

### S3 Buckets
- **Source bucket**: `{bucket_name}-source-{region}-{account_id}`
- **Replica bucket**: `{bucket_name}-replica-{region}-{account_id}`
- Both buckets have:
  - Versioning enabled
  - Public access blocked
  - Replication configured (source → replica)

### Lambda Function
- **Name**: `empty-s3-buckets`
- **Runtime**: Python 3.12 (ARM64)
- **Timeout**: 300 seconds
- **Purpose**: Deletes all object versions and delete markers from both buckets

### IAM Roles
- S3 replication role with permissions to replicate objects
- Lambda execution role with permissions to list and delete objects

## Usage

### 1. Configure Variables

Create or edit `terraform.tfvars`:

```hcl
bucket_name = "my-bucket"
```

### 2. Initialize and Apply

```bash
terraform init
terraform plan
terraform apply
```



## Variables

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `bucket_name` | Bucket name prefix | string | Yes |
| `default_tags` | Default tags for all resources | map(string) | No |

## Outputs

The bucket names and Lambda function ARN can be added as outputs if needed.

## Security Features

- Public access blocked on all buckets
- IAM roles follow least privilege principle
- Lambda has reserved concurrency of 1 to prevent concurrent executions
- Versioning enabled for data protection

### Checkov Security Scan

```
Passed checks: 26
Failed checks: 0
Skipped checks: 5
```

All security checks passed. Skipped checks are intentionally disabled for this use case (X-Ray tracing, VPC configuration, DLQ, code signing, and environment variable encryption not required for manual bucket cleanup operations).

## Cleanup

Before destroying the infrastructure, you must empty both buckets:

```bash
# Empty buckets using Lambda function
aws lambda invoke --function-name empty-s3-buckets response.json

# Destroy infrastructure
terraform destroy
```

## Notes

- The Lambda function must be invoked manually before destroying the infrastructure
- Replication only applies to new objects after configuration is enabled
- Delete markers are also replicated from source to replica
