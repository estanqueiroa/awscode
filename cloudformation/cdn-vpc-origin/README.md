# CloudFront Distribution with VPC Origin (EC2 Instance)

This CloudFormation template creates a CloudFront distribution that uses an EC2 instance in a private subnet as its origin. The setup provides a secure way to deliver web content while keeping the EC2 instance protected from direct internet access.

## Architecture

* CloudFront Distribution as the content delivery network
* EC2 instance running Apache in a private subnet
* Security Group configured to allow only CloudFront origin IPs
* (Optional) CloudWatch logging for monitoring and troubleshooting

## Prerequisites

An existing VPC with:
* Private subnet
* NAT Gateway (for EC2 internet access)
* EC2 key pair for SSH access
* Appropriate IAM permissions to create all resources

## Quick Deploy


* Option 1 (Recommended) Use [**RAIN**](https://github.com/aws-cloudformation/rain):

```bash
rain deploy cdn-vpc-origin.yml
```

* Option 2 - Use AWS CLI

```bash 
aws cloudformation create-stack \
  --stack-name cloudfront-vpc-origin \
  --template-body file://template.yaml \
  --parameters \
    ParameterKey=pVpcId,ParameterValue=vpc-xxxx \
    ParameterKey=pPrivateSubnetId,ParameterValue=subnet-xxxx \
    ParameterKey=pKeyName,ParameterValue=your-key-pair \
    ParameterKey=pEnableLogging,ParameterValue=true
```

    
## Parameters

* pVpcId - ID of the VPC where EC2 will be deployed
* pPrivateSubnetId - ID of the private subnet for EC2
* pKeyName - EC2 SSH key pair name
* pEnableLogging - Enable CloudWatch logging (true/false)

## Security Features

* EC2 instance in private subnet
* Security Group allowing only CloudFront origin IPs (pl-3b927c52)
* Geo-restriction capabilities
* Optional CloudWatch logging

## Resource Details

EC2 Instance:

* t2.micro running Amazon Linux 2
* Apache web server
* Custom index.html with instance ID

CloudFront Distribution:

* HTTP/2 enabled
* IPv6 enabled
* Configurable geo-restrictions
* Origin request policy: Managed-AllViewer
* Cache policy: UseOriginCacheControlHeaders

Security Group:

* Inbound: HTTP (80) from CloudFront only
* Outbound: All traffic allowed

## Logging and Monitoring

When enabled (pEnableLogging=true):

* Creates CloudWatch Log Group
* Sets up CloudFront access logging
* 14-day log retention
* Logs delivered via AWS Logs Delivery

## Outputs

* oWebServerPublicDNS -	Private DNS of EC2 instance
* oCloudFrontDomainName - CloudFront distribution domain
* oCWlogging - CloudWatch log group name (if enabled)

## Important Notes

* Ensure your VPC has appropriate NAT Gateway configuration
* The template uses prefix list pl-3b927c52 for CloudFront IPs
* You may need to request a quota increase for prefix lists
* The distribution is configured with specific geo-restrictions (US, CA, GB, BR)

## Troubleshooting

* Check CloudWatch logs (if enabled)
* Verify Security Group rules
* Confirm EC2 instance health status
* Test direct access from within VPC

## References
[VPC Origins Documentation](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-vpc-origins.html)

[AWS Blog Post on VPC Origins](https://aws.amazon.com/blogs/networking-and-content-delivery/introducing-cloudfront-virtual-private-cloud-vpc-origins-shield-your-web-applications-from-public-internet/)

## Tags

Resources are tagged with:

* Solution-Stack-CFN: ${StackName}

## Cleanup

Delete CloudFormation stack to remove all resources using AWS Console or Use RAIN `rain rm stackname`