##################################################################################################
# AWS Architecture with Application Load Balancer and API Gateway integrated with Lambda functions
##################################################################################################

This CloudFormation template creates an AWS architecture with two Lambda functions, one integrated with an API Gateway and other integrated with Application Load Balancer (ALB).


![Alt text](../diagrams/lambda-apigw-alb.png?raw=true "Diagram Image")

# Resources Created

The CloudFormation template creates the following resources:

- Application Load Balancer (ALB): The load balancer that receives incoming traffic from clients.
- ALB Listener: The listener that forwards traffic from the ALB to the target group.
- ALB Target Group: The target group that the ALB forwards traffic to, which is a Lambda function.
- API Gateway: The API Gateway that serves as the entry point for the application's API.
- API Gateway Method: The method configured on the API Gateway to integrate with the Lambda function.
- Lambda Function: A sample Lambda function that will be executed when the API Gateway receives a request.
- Lambda Role: The IAM role associated with the Lambda function, granting it the necessary permissions to execute.
- API Gateway Deployment: The deployment of the API Gateway to the 'prod' stage.
- ALB Security Group: The security group for the Application Load Balancer, allowing inbound traffic on port 80.

# Parameters

* VpcId: This parameter allows you to specify the VPC ID where the resources will be created. The AWS::EC2::VPC::Id type ensures that the value entered is a valid VPC ID.

* PublicSubnets: This parameter allows you to specify a list of public subnet IDs, which will be used for the Application Load Balancer. The List<AWS::EC2::Subnet::Id> type ensures that the values entered are valid subnet IDs.

* YourIPAddress: This parameter allows you to specify your public IP address, which will be used to configure the ingress rule for the ALB security group. The String type is used, and the default value is set to **************/32, which represents your IP address with a /32 CIDR block.

* apiGatewayStageName: This parameter allows you to specify the stage name for the API Gateway. The String type is used, and the AllowedPattern property ensures that the value entered consists of only lowercase letters and numbers. The default value is set to call.

* apiGatewayHTTPMethod: This parameter allows you to specify the HTTP method for the API Gateway. The String type is used, and the default value is set to POST.

# Deployment

To deploy this architecture, follow these steps:

You first need to create stack without the Target ARN, then you can uncomment this section and update the stack:

```bash
  # ALB Target Group
  rALBTargetGroup:
    Type: AWS::ElasticLoadBalancingV2::TargetGroup
    Properties:
      HealthCheckPath: /
      Name: ALB-TargetGroup
      TargetType: lambda
      # remove comment after first deployment
      # Targets:
      #   - Id: !GetAtt rLambdaFunctionALB.Arn
```

- Save the CloudFormation template to a file (e.g., api-gateway-alb.yml).
- Use the AWS CLI or the AWS Management Console to create a new CloudFormation stack with the template.
- Provide the necessary input parameters, such as the VPC ID and the public subnet IDs.
- Wait for the stack creation to complete.

You can also use [RAIN](https://github.com/aws-cloudformation/rain) to deploy the stack (Recommended):

```bash
rain deploy api-gateway-alb.yaml --tags tag1=value1,tag2=value2
```

# Testing

To test the deployed architecture, follow these steps:

**API GAteway:**

Don´t use web browser (it will return error message "{"message":"Missing Authentication Token"}")

- In the AWS Management Console, navigate to the CloudFormation service, select the created stack, "Outputs" section and copy the Invoke URL for the "call" stage.
- Open a Linux Shell terminal and use a tool like Postman or cURL to send a request to the API Gateway endpoint.

```bash
curl --request POST https://rnk0lfld0b.execute-api.us-east-1.amazonaws.com/call
{"statusCode": 200, "body": "\"Hello from Lambda with API Gateway!\""}
```
- Verify that you receive a successful response (HTTP status code 200) with the message "Hello from Lambda wity API Gateway!".

**ALB:**

You can use web browser.

- In the AWS Management Console, navigate to the CloudFormation service, select the created stack, "Outputs" section and copy the DNS name of the Application Load Balancer.
- Use a web browser or a tool like cURL to send a request to the ALB endpoint.

```bash
http://lambda-rappl-kgm1sil5dm7h-1861522055.us-east-1.elb.amazonaws.com/
```

- Verify that the request is forwarded to the Lambda function and you receive a response "Hello World from Lambda using ALB".

# Cleaning up
To delete the resources created by this CloudFormation template, simply delete the CloudFormation stack.

Remove stack using RAIN:

```bash
rain rm api-gateway-alb
```

# Troubleshooting

* Cannot open up the ALB URL: Verify your IP address is correct in the Security Group rule.

* Error {"message":"Missing Authentication Token"}: You are testing API Gateway using web browser, use a Linux terminal with CURL instead.

* Error {"message":"Forbidden"}: Verify the API GATEWAY Invoke URL is complete including the stage name at the end.

* Error "Resource handler returned message: "elasticloadbalancing principal does not have permission to invoke arn:aws:lambda.... (Service: ElasticLoadBalancingV2, Status Code: 403, Request ID: 52723aa0-6b54-404d-84ac-029dfd1a6dde)" (RequestToken: 5ce76182-a768-897c-eda0-ba1cbdbe4e08, HandlerErrorCode: AccessDenied): You first need to create stack without the Target ARN, then you can uncomment this section and update the stack:

```bash
  # ALB Target Group
  rALBTargetGroup:
    Type: AWS::ElasticLoadBalancingV2::TargetGroup
    Properties:
      HealthCheckPath: /
      Name: ALB-TargetGroup
      TargetType: lambda
      # remove comment after first deployment
      # Targets:
      #   - Id: !GetAtt rLambdaFunctionALB.Arn
```


# References
[AWS Documentation: Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
[AWS Documentation: API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
[AWS Blog: Serverless Architecture with Amazon API Gateway and AWS Lambda](https://aws.amazon.com/blogs/compute/serverless-architecture-with-amazon-api-gateway-and-aws-lambda/)
[AWS Demo](https://exampleloadbalancer.com/)
[AWS Samples ALB Serverless App](https://github.com/aws/elastic-load-balancing-tools/tree/master/application-load-balancer-serverless-app)
[CloudFormation API Gateway integration to Lambda function](https://gist.github.com/magnetikonline/c314952045eee8e8375b82bc7ec68e88)
