# AWS CloudFormation Template for ECS Cluster, Service, and Task Definition with ALB

This AWS CloudFormation template creates an ECS (Elastic Container Service) cluster, service, and task definition, along with an Application Load Balancer (ALB) to expose the application.

## Table of Contents

- [Introduction](#introduction)
- [Resources](#resources)
- [Usage](#usage)
- [Parameters](#parameters)
- [Outputs](#outputs)
- [Deployment](#deployment)
- [Security Considerations](#security-considerations)
- [Monitoring and Logging](#monitoring-and-logging)
- [Cost Estimation](#cost-estimation)
- [Cleanup](#cleanup)
- [Limitations and Assumptions](#limitations-and-assumptions)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This CloudFormation template is designed to provision an ECS cluster, service, and task definition, along with an ALB to handle incoming traffic to the application. The template provides a starting point for deploying containerized applications on AWS using ECS with Fargate nodes (serverless).

Based on this <a href="https://medium.com/@ayushunleashed/how-to-build-ecs-ec2-auto-scaling-infrastructure-on-aws-ba730aa076a9">awesome article</a> from <a href="https://www.linkedin.com/in/ayushunleashed/">Ayush Yadav</a>

![Alt text](../diagrams/ecs-cluster.png?raw=true "Diagram Image")

## Resources

The template creates the following resources:

- **ECS Cluster**: An ECS cluster to host the application containers.
- **ECS Task Definition**: The task definition that defines the container image and configuration for the application.
- **ECS Service**: The service that manages the deployment and scaling of the application containers.
- **Application Load Balancer**: The load balancer that distributes traffic to the application containers.
- **Security Groups**: Security groups for the ECS service and the ALB to control inbound and outbound traffic.
- **IAM Roles**: IAM roles for the ECS task and execution, granting the necessary permissions.

## Usage

To use this template, you'll need to have the following prerequisites:

- An AWS account with the necessary permissions to create the resources.
- The VPC ID and subnet IDs where the resources will be deployed.
- The container image to be used for the task definition.
- The container port for the application.
- Your public IP address (in `/32` format) for accessing the ALB.

## Parameters

The template provides the following parameters:

- `pContainerImage`: The container image to use for the task definition.
- `pVPC`: The VPC ID where the resources will be deployed.
- `pSubnets`: The subnet IDs where the resources will be deployed.
- `pContainerPort`: The container TCP port.
- `pMyIPAddress`: Your public IP address (in `/32` format) for accessing the ALB.

## Outputs

The template provides the following outputs:

- `oECSClusterName`: The name of the ECS cluster.
- `oECSServiceName`: The name of the ECS service.
- `oApplicationLoadBalancerDNSName`: The DNS name of the Application Load Balancer.

## Deployment

To deploy the template, you can use the AWS CloudFormation console, AWS CLI, or AWS SDK. Provide the necessary parameter values and deploy the template.

## Security Considerations

- The template creates security groups to control inbound and outbound traffic for the ECS service and the ALB.
- The ALB security group allows inbound traffic only from the specified IP address (your public IP address) on the container port.
- The ECS service security group allows inbound traffic only from the ALB security group on the container port.
- The template suppresses some CloudFormation Linter (cfn-nag) rules, as they are not applicable for this specific use case.

## Monitoring and Logging

This template does not include specific monitoring and logging configurations. It's recommended to set up appropriate CloudWatch alarms and logs to monitor the health and performance of the ECS cluster, service, and ALB.

## Cost Estimation

For a setup with 10 Fargate tasks running 1 hour per day, the total estimated monthly cost is $14.67.

The cost breakdown is as follows:

1. **Fargate Compute Costs**:
   - CPU cost: $3.04
   - Memory cost: $0.63
   - Total Fargate Compute Costs: $3.67

2. **Application Load Balancer (ALB) Costs**:
   - Load Balancer-hours: $6.75
   - Data Processed: $4.25
   - Total ALB Costs: $11.00

3. **Total Estimated Monthly Cost**: $14.67

Please note that these are estimates, and the actual costs may vary depending on your specific usage patterns and any additional services or features you might use.

## Cleanup

To clean up the resources created by this template, you can simply delete the CloudFormation stack.

## Limitations and Assumptions

- This template is designed for a basic deployment scenario and may not cover all advanced use cases.
- The template assumes the use of Fargate as the launch type for the ECS service.
- The template does not include any custom application-specific configurations or deployments.

## Contributing

If you find any issues or have suggestions for improving the template, feel free to open an issue or submit a pull request on the repository.

## License

This CloudFormation template is provided under the [MIT License](LICENSE).