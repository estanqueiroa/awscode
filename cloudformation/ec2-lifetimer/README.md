# Lifetimer Application CloudFormation Template

## Overview
This CloudFormation template deploys a simple web application that calculates life statistics based on birth dates. 
The application runs in a Docker container on an EC2 instance with automated setup and configuration.
Application Load Balancer is added in front of EC2 instance for better security, not configuring EC2 instance public IP for external direct access.

![Alt text](screenshot.jpg?raw=true "Diagram Image")

## Architecture

- One EC2 Instance (t2.micro by default)
- Application Load Balancer (internet facing)
- Docker container running Nginx
- Security Group with HTTP and SSH access
- Automated deployment using UserData
- Region-specific AMI mapping

## Prerequisites
- AWS Account
- VPC created with 02 Public and at least 1 Private subnets. The Private subnet requires internet access using NAT gateway.
- AWS CLI installed and configured
- Existing EC2 Key Pair
- IAM permissions for CloudFormation and EC2

## Quick Start

### 1. Deploy the Stack
```bash
aws cloudformation create-stack \
    --stack-name lifetimer-stack \
    --template-body file://lifetimer-template.yaml \
    --parameters ParameterKey=KeyName,ParameterValue=your-key-pair-name
```

### 2. Testing

* Get ALB DNS name from CloudFormation stack Outputs or using AWS CLI:

```bash
aws cloudformation describe-stacks \
    --stack-name lifetimer-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`oALBDNSName`].OutputValue' \
    --output text
```

* Then open in browser: http://alb-dns-name-address


## Cleanup

Delete CloudFormation stack:

```bash
aws cloudformation delete-stack --stack-name lifetimer-stack
```

## Contributing

* Fork the repository
* Create feature branch
* Submit pull request

## License
MIT License

## Support
* Create GitHub issue
* Contact maintainer

## Version History
* 1.0.0: Initial release
* 1.0.1: Added region mapping