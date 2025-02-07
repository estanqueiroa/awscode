# Lifetimer Application CloudFormation Template

## Overview
This CloudFormation template deploys a simple web application that calculates life statistics based on birth dates. The application runs in a Docker container on an EC2 instance with automated setup and configuration.

![Alt text](screenshot.jpg?raw=true "Diagram Image")

## Architecture

- One EC2 Instance (t2.micro by default)
- Docker container running Nginx
- Security Group with HTTP and SSH access
- Automated deployment using UserData
- Region-specific AMI mapping

## Prerequisites
- AWS Account
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

# Get public IP from CloudFormation stack Outputs or using AWS CLI:
aws cloudformation describe-stacks \
    --stack-name lifetimer-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`PublicIP`].OutputValue' \
    --output text

Then open in browser: http://<public-ip>


## Cleanup

Delete CloudFormation stack:

```bash
aws cloudformation delete-stack --stack-name lifetimer-stack
```

## Docker Image creation (Optional Steps)


To deploy this application, you'll need to:

Create a Dockerfile for the HTML application:

```bash
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
```   
    
## Build and push the Docker image to AWS ECR repo:
    
* Login to ECR
```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
```

* Build the image
```bash
docker build -t days-calculator .
```

* Tag the image
```bash
docker tag days-calculator:latest <account-id>.dkr.ecr.<region>.amazonaws.com/days-calculator-repo:latest
```

* Push the image
```bash
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/days-calculator-repo:latest
```

## Build and push image to Docker Hub repo:


* Build
```bash
docker build -t estanqueiroa/lifetimer:latest .
```

```bash
* Verify
docker images | grep lifetimer
```

* Login (if needed)
```bash
docker login
```

* Push
```bash
docker push estanqueiroa/lifetimer:latest
```

## To test the image locally before pushing

* Run container locally
```bash
docker run -d -p 8080:80 estanqueiroa/lifetimer:latest
```

* Check if it's running
```bash
docker ps
```

* Access http://localhost:8080 in your browser

## Docker Hub repo

[Docker image Link](https://hub.docker.com/r/estanqueiroa/lifetimer)

Docker pull command: `docker pull estanqueiroa/lifetimer`

## Test Docker image using EC2 instance

```bash
# Launch EC2 instance
aws ec2 run-instances \
    --image-id ami-0cff7528ff583bf9a \
    --instance-type t2.micro \
    --key-name your-key-pair \
    --security-groups your-sgrp \
    --user-data '#!/bin/bash
        yum update -y
        yum install -y docker
        service docker start
        systemctl enable docker
        docker run -d -p 80:80 estanqueiroa/lifetimer:latest'
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