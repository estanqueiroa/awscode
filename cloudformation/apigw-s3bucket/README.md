# API Gateway S3 File Upload/Download Solution

This CloudFormation template creates a serverless solution that enables file uploads and downloads to/from Amazon S3 through API Gateway. The solution supports binary file types and implements a RESTful API interface.

## Architecture

The solution deploys the following AWS resources:

- Amazon S3 bucket for file storage
- API Gateway REST API with binary support
- IAM role for API Gateway to access S3
- API endpoints for PUT (upload) and GET (download) operations

## Prerequisites

- AWS Account
- AWS CLI installed and configured (optional)
- Basic understanding of AWS services (S3, API Gateway, IAM)

## Deployment

### Option 1: AWS Management Console

1. Navigate to the AWS CloudFormation console
2. Click "Create stack" and choose "With new resources"
3. Upload the template file
4. Enter a stack name
5. Review and create the stack

## Usage

After deployment, you'll receive two outputs:

- oApiEndpoint: The API Gateway endpoint URL
- oBucketName: The name of the created S3 bucket

Update these values in the `testing.sh` script and run it to validate the solution.

## Features
- Binary file support (all file types)
- Simple REST API interface
- Serverless architecture

## Limitations
- Maximum file size limit of 10MB (API Gateway limit)
- No built-in authentication (can be added separately)
- Cross-region operations not supported

## Cleanup

- delete files from S3 bucket
- delete CloudFormation stack to remove all resources: `aws cloudformation delete-stack --stack-name my-file-upload-solution`

## References

[Upload files to S3 through API Gateway](https://awstip.com/uploading-files-to-s3-through-api-gateway-7bb78c0d0483)

[AWS Knowledge Center - API Gateway upload image to S3](https://repost.aws/knowledge-center/api-gateway-upload-image-s3)