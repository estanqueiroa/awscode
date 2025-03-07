# CloudFormation template 

This template sets up an Application Load Balancer (ALB) with three domains pointing to different EC2 instances using Listener rules with Host Header parameter.

## This template creates:

* Security groups for both ALB and EC2 instances
* Four EC2 instances with Apache web server installed
* An Application Load Balancer
* Three target groups (one for each EC2 instance) and one for Default rule
* Listener rules that route traffic based on domain names

To use this template make sure you have:

* A VPC with at least two public subnets
* A key pair for EC2 instances
* Your domain names ready

## Deployment

When launching the CloudFormation stack, you'll need to provide:

* VPC ID
* Two public subnet IDs
* Instance type (defaults to t2.micro)
* Key pair name
* Three domain names

After the stack is created:

* Get the ALB DNS name from the stack outputs
* Create CNAME records in your DNS provider pointing your domains to the ALB DNS name

**Note:** This template sets up HTTP only. For production use, you should add HTTPS listeners and certificates using AWS Certificate Manager.

## Testing

* Using curl command
    
# Test each domain using the Host header

```bash
curl -H "Host: domain1.com" http://<ALB-DNS-NAME>
curl -H "Host: domain2.com" http://<ALB-DNS-NAME>
curl -H "Host: domain3.com" http://<ALB-DNS-NAME>
```

* Using wget

```bash    
wget --header="Host: domain1.com" http://<ALB-DNS-NAME>
wget --header="Host: domain2.com" http://<ALB-DNS-NAME>
wget --header="Host: domain3.com" http://<ALB-DNS-NAME>
```

## Cleanup

* Delete CloudFormation stack to delete all resources