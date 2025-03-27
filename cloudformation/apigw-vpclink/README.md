# How to Use AWS API Gateway VPC Link for Secure Access to Private VPC Resources

In this [guide](https://medium.com/@shivkaundal/how-to-use-aws-api-gateway-vpc-link-for-secure-access-to-private-vpc-resources-5d350bdac903), we will explore how to use AWS API Gateway VPC Link feature to securely connect API Gateway to private resources within a VPC,
such as EC2 instances or ECS services. 

This setup allows you to expose internal services to the internet without compromising security, as traffic stays within AWS private network.

## Deployment

This Cloudformation template will set up an EC2 instance with Apache HTTP server in a private subnet to simulate a backend resource. 
Then use AWS VPC Link and Network Load Balancer (NLB) to create a secure connection between API Gateway and the EC2 instance.

Run [RAIN](https://github.com/aws-cloudformation/rain) command (recommended): `rain deploy apigw-vpclink.yml`

## Architecture

The template creates the following resources:

1. An EC2 instance in a private subnet with Apache HTTP Server installed
2. A Network Load Balancer (NLB) in the private subnet
3. Security groups for both EC2 and NLB
4. An API Gateway with VPC Link
5. Integration between API Gateway and the private EC2 via NLB

## Prerequisites

Before deploying this template, ensure you have:

1. An existing VPC with at least one private subnet
2. Necessary IAM permissions to create the resources defined in the template
3. AWS CLI configured (if deploying via command line)

## Parameters

The template requires the following parameters:

- `VpcId`: The ID of your existing VPC
- `PrivateSubnet1`: The ID of the private subnet where the EC2 instance and NLB will be deployed
- `InstanceType`: The EC2 instance type (default: t2.micro)
- `AllowedIPAddress`: Your IP address to allow access to API Gateway (e.g., 1.2.3.4/32) https://checkip.amazonaws.com/

## Deployment

To deploy this template:

1. Open the AWS CloudFormation console or use AWS CLI
2. Create a new stack and upload the template file
3. Fill in the required parameters
4. Review and create the stack
5. Deploy the API using AWS Console to apply Resource Policy configuration (restrict access based on Ip Address)

## Outputs

After successful deployment, the stack will provide the following outputs:

- `ApiEndpoint`: The URL of the API Gateway endpoint
- `EC2PrivateIP`: The private IP address of the EC2 instance
- `NLBDNSName`: The DNS name of the Network Load Balancer
- `CURLtest`: A curl command to test the API Gateway endpoint

## Testing

To test the deployment, use the curl command provided in the `CURLtest` output. This should return a simple HTML page served by the private EC2 instance.

## Deploy your API

**Important:** You must redeploy your REST API each time you change its resource policy.

- In the Resources pane of your REST API, Choose Deploy API.
- For Deployment stage, choose `prod`.
- Choose Deploy.

## Security Note

This template creates security groups with specific ingress rules. Review and adjust these rules according to your security requirements before deploying in a production environment.

**Get all IPv4 addresses for a specific service in a specific Region**

https://docs.aws.amazon.com/vpc/latest/userguide/aws-ip-work-with.html#filter-ip-ranges-ipv4-service-region

Download the JSON file: `curl -O https://ip-ranges.amazonaws.com/ip-ranges.json`

Query for API Gateway ranges: `jq -r '.prefixes[] | select(.region=="us-east-1") | select(.service=="API_GATEWAY") | .ip_prefix' < ip-ranges.json`

You can create a prefix list for these IP ranges and configure NLB security group to use it in the Ingress rule:

```bash
3.216.135.0/24
3.216.136.0/21
3.216.144.0/23
3.216.148.0/22
3.235.26.0/23
3.235.32.0/21
3.238.166.0/24
3.238.212.0/22
44.206.4.0/22
44.210.64.0/22
44.212.176.0/23
44.212.178.0/23
44.212.180.0/23
44.212.182.0/23
44.218.96.0/23
44.220.28.0/22
```

## Costs

This template creates AWS resources that may incur costs. Please review the AWS pricing for EC2, NLB, and API Gateway before deploying.

## License

This template is provided "AS IS" without warranties or conditions of any kind. Use at your own risk.

## References

For more information on using API Gateway VPC Link, refer to:
https://medium.com/@shivkaundal/how-to-use-aws-api-gateway-vpc-link-for-secure-access-to-private-vpc-resources-5d350bdac903

RAIN tool: https://github.com/aws-cloudformation/rain

[API Gateway resource policies](https://repost.aws/knowledge-center/api-gateway-resource-policy-access)

## Cleanup

To avoid ongoing charges, remember to delete the CloudFormation stack when you're done testing.

RAIN command to delete stack: `rain rm apigw-vpclink`
