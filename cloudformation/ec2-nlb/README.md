# EC2 Web Server with Network Load Balancer

This AWS CloudFormation template deploys a simple web server architecture with the following components:

- EC2 instance running Apache web server
- Network Load Balancer (NLB) in front of the EC2 instance
- Required security groups and networking components

## Prerequisites

- An existing VPC with public subnets
- An EC2 key pair
- AWS CLI or AWS Console access

## Parameters

- `pVpcId`: ID of the target VPC
- `pSubnetIds`: List of public subnet IDs for the NLB (minimum 2)
- `pInstanceSubnetId`: Subnet ID for EC2 instance placement
- `pKeyName`: Name of existing EC2 key pair
- `pInstanceType`: EC2 instance type (default: t3.micro)
- `pProjeto`: Value for Project tag (default: projeto12345)

## Resources Created

- EC2 instance with Apache web server
- Network Load Balancer
- Security Group allowing HTTP (80) and SSH (22) access
- Target Group for health checks
- Listener on port 80

## Outputs

- EC2 instance private IP
- Load Balancer DNS name
- Target Group ARN

## Testing

1. After stack creation, wait approximately 5 minutes for the instance to complete initialization
2. Access the web server using the Load Balancer DNS name (found in Outputs)
3. Verify that you see the message: "Hello from AWS CloudFormation + NLB + EC2!"
4. Check NLB health checks in the AWS Console:
- Navigate to EC2 > Target Groups
- Select the created target group
- Verify the instance is "healthy"

### Troubleshooting
- If the webpage is not accessible:
- Verify security group rules
- Check instance health in target group
- Review instance system logs for Apache errors
- Ensure subnets have proper routing to internet gateway

## Supported Regions

- us-east-1
- us-east-2
- us-west-1
- us-west-2

## License

This template is licensed under the Apache License, Version 2.0.
