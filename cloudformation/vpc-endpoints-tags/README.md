# VPC Endpoints Tagging with CloudFormation Custom Resource and Lambda

This CloudFormation (CFN) template creates a private VPC with two private subnets, and also sets up VPC endpoints for Amazon CloudWatch Logs, Amazon S3, and Amazon DynamoDB. Additionally, it includes a Lambda function that automatically tags the VPC endpoints with custom tags.

![Alt text](../diagrams/custom-resource.png?raw=true "Diagram Image")

You can trigger the Lambda using a Custom Resouce in the same stack, or a Custom Resource created in another stack (using !ImportValue), this CFN templates includes examples for both scenarios.

## Parameters

* pVPCName: The name of the VPC.
* pVPCCidr: The CIDR block for the VPC.
* pTagKey1: The first tag key to apply to the VPC endpoints.
* pTagValue1: The first tag value to apply to the VPC endpoints.
* pTagKey2: The second tag key to apply to the VPC endpoints.
* pTagValue2: The second tag value to apply to the VPC endpoints.

## Resources

VPC and Subnets:

* Creates a private VPC with the specified CIDR block.
* Creates two private subnets in different availability zones.
* Creates a private route table and associates it with the private subnets.

VPC Endpoints:

* Creates a security group to govern access to the VPC endpoints.
* Creates a VPC endpoint for Amazon CloudWatch Logs.
* Creates a VPC gateway endpoint for Amazon S3.
* Creates a VPC gateway endpoint for Amazon DynamoDB.

Lambda Function and Custom Resource:

* Creates an IAM role for the Lambda function.
* Creates a Lambda function that tags the VPC endpoints with the specified tags.
* Creates a CloudFormation custom resource that triggers the Lambda function to tag the VPC endpoints.

## Outputs

* oTaggingLambdaId: The ARN of the tagging Lambda function.
* oVPC: The ID of the created VPC.
* oPrivateSubnet1: The ID of the first private subnet.
* oPrivateSubnet2: The ID of the second private subnet.

## Usage

* Deploy the CloudFormation stack using the AWS CLI, AWS Management Console, or AWS RAIN. Customize the parameter values as needed.
* After the stack is deployed, the VPC endpoints will be automatically tagged with the specified tags.

## Notes

* The Lambda function used in this template is designed to be used as a custom resource within the same CloudFormation stack. However, the template also includes a commented-out section that shows how you can use the same Lambda function from another stack to tag VPC endpoints created in that stack.
* The Lambda function uses the cfnresponse module to communicate the success or failure of the tagging operation back to CloudFormation.
* The Lambda function uses the get_service_name_suffix function to extract the service name suffix from the VPC endpoint service name. This is done to set a more meaningful name for the VPC endpoints.
* The template includes several Checkov rules that have been skipped, as they are not applicable to this specific use case.

## Cost Estimation

To estimate the costs associated with this CloudFormation template, you can use the AWS Pricing Calculator (https://calculator.aws.amazon.com/). Here's a breakdown of the potential costs:

* VPC and Subnets: The VPC and subnets themselves do not incur any direct charges, but they may impact the cost of other resources that are deployed within them.

VPC Endpoints:

* CloudWatch Logs Endpoint: This is an interface-type VPC endpoint, which has a charge per hour of usage. The cost will depend on the amount of data processed through the endpoint.
* S3 and DynamoDB Endpoints: These are gateway-type VPC endpoints, which do not incur any direct charges.

Lambda Function: The Lambda function used to tag the VPC endpoints will incur charges based on the number of invocations and the duration of each invocation. The cost will depend on the number of VPC endpoints and the frequency of the tagging operation.

## Cleanup

To clean up the resources created by this CloudFormation template, follow these steps:

* Delete the CloudFormation stack. This will remove all the resources created by the template, including the VPC, subnets, VPC endpoints, and the Lambda function.

Verify that all the resources have been successfully deleted. You can do this by checking the AWS Management Console or by using the AWS CLI.