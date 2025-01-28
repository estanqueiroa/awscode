# S3 Static Website with Tic-Tac-Toe Game

This CloudFormation template deploys a static website hosting a Tic-Tac-Toe game using AWS S3 and Lambda.

![Alt text](../diagrams/game.png?raw=true "Diagram Image")

## Architecture

- **S3 Bucket**: Hosts the static website content
- **Lambda Function**: Handles the upload of HTML content
- **IAM Role**: Provides necessary permissions for Lambda execution

## Features

- Single-page Tic-Tac-Toe game
- Responsive design
- Automatic win detection
- Turn-based gameplay (X and O players)
- Public access enabled for website viewing

## Resources Created

1. S3 Bucket with website hosting configuration
2. Bucket policy for public read access
3. Lambda function for content deployment and CloudWatch log group for Lambda logs
4. IAM role with required permissions

## Cost Estimate (Monthly)

### Within Free Tier
- Total Cost: $0

### Outside Free Tier (10,000 visits/month)
- S3 Storage: < $0.01
- S3 GET Requests: ~$0.004
- Lambda: Effectively $0
- **Total**: < $0.02/month

## Deployment

1. Upload the template to CloudFormation
2. Create a stack with a unique name
3. Wait for stack creation to complete
4. Access the website using the URL from the stack outputs

## Stack Outputs

- `WebsiteURL`: The URL of the deployed website
- `S3BucketName`: Name of the created S3 bucket

## Technical Details

- **AWS Template Version**: 2010-09-09
- **Lambda Runtime**: Python 3.12 (ARM64/Graviton)
- **Lambda Timeout**: 10 seconds
- **Content Type**: HTML with embedded CSS and JavaScript

## Security

- S3 bucket configured for public access
- Lambda function has minimal required permissions
- HTTPS not included (consider CloudFront for HTTPS)

## Cleanup

- Delete CloudFormation stack to delete all resources (S3 bucket, Lambda function, IAM role)
- Delete CloudWatch log group created for Lambda logs

## Note

Pricing is based on AWS rates as of April 2024. For current pricing, visit:
https://calculator.aws.amazon.com