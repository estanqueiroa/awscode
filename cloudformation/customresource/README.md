# CloudFormation Custom Resource Example - Add Tags to VPC Endpoints

This CloudFormation template creates a custom resource to add tags to a VPC Endpoint.

![Alt text](../diagrams/custom-resource.png?raw=true "Diagram Image")

## Parameters

- **`pVpcEndpointId`**: The ID of the VPC Endpoint to be tagged.
- **`pTagKey`**: The tag key to be applied to the VPC Endpoint.
- **`pTagValue`**: The tag value to be applied to the VPC Endpoint.

## Resources

1. **`rLambdaExecutionRole`**: An IAM role for the Lambda function, with the necessary permissions to describe and create tags on the VPC Endpoint.

2. **`rVpcEndpointTaggerFunction`**: A Lambda function that handles the custom resource lifecycle events (Create, Update, Delete) and applies the specified tags to the VPC Endpoint.

3. **`rVpcEndpointTagger`**: The custom resource that triggers the `rVpcEndpointTaggerFunction` Lambda function to add tags to the VPC Endpoint.

The Lambda function uses the following environment variables:

- **`oTagKey`**: The tag key to be applied to the VPC Endpoint.
- **`oTagValue`**: The tag value to be applied to the VPC Endpoint.

The template also includes some Checkov and CFN Nag (a static code analysis tools) suppressions for the Lambda function, as they are not required for this specific use case.

## Usage

1. Deploy the CloudFormation stack, providing the necessary parameter values:
   - `pVpcEndpointId`: The ID of the VPC Endpoint to be tagged.
   - `pTagKey`: The tag key to be applied.
   - `pTagValue`: The tag value to be applied.

2. The custom resource will trigger the Lambda function to add the specified tags to the VPC Endpoint.

3. You can verify the tags by checking the VPC Endpoint properties in the AWS Management Console.

## Cost Considerations

The resources created by this CloudFormation template may incur the following costs:

1. **IAM Role**: There is no direct cost for creating an IAM role, but it is part of the overall AWS Identity and Access Management (IAM) service, which has pricing based on the number of IAM requests and the size of the IAM data store.

2. **Lambda Function**: The cost of the Lambda function depends on the number of invocations, the duration of each invocation, and the amount of memory used. Refer to the [AWS Lambda pricing](https://aws.amazon.com/lambda/pricing/) for more information.

3. **VPC Endpoint**: There is a cost associated with VPC Endpoints, which is based on the number of VPC Endpoints, the amount of data transferred, and the region. Refer to the [Amazon VPC Pricing](https://aws.amazon.com/vpc/pricing/) for more details.

4. **CloudFormation**: There is no direct cost for using CloudFormation, but it is part of the overall AWS CloudFormation service, which has pricing based on the number of API requests and the amount of data transferred.

It's important to consider these costs when deploying this CloudFormation template and to monitor the usage and costs associated with the resources created.

Note: This is a basic example, and you may need to add additional error handling, logging, and other features to make it more robust and production-ready.