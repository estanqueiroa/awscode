# CloudFormation Template: Create an EC2 Instance as a Proxy Server

## Description

This CloudFormation template creates an EC2 instance and configures it as a proxy server. The instance is launched using the latest Amazon Linux 2 AMI and includes the following components:

* Squid proxy server
* Proxy environment variables configured in the user's shell profile

The template also creates a security group that allows inbound HTTP and HTTPS traffic to the proxy server instance.

## Parameters

The template has the following parameters:

* KeyPair: The name of an existing EC2 KeyPair to enable SSH access to the instance.
* VpcId: The ID of the VPC where the proxy server will be deployed.
* VpcCIDR: The CIDR block of the VPC


## Resources

**ProxyInstance**: This is the main resource that creates the EC2 instance and configures it as a proxy server. The key features of this resource are:

* ImageId: The latest Amazon Linux 2 AMI in the us-east-1 region.
* InstanceType: t2.micro.
* SecurityGroupIds: The ID of the ProxySecurityGroup resource.
* UserData: The user data script that installs and configures the proxy server using cfn-init.
* CreationPolicy: Specifies a resource signal timeout of 5 minutes, ensuring that the stack creation waits for the instance to be fully configured before completing.

**ProxySecurityGroup**: This resource creates a security group that allows inbound HTTP and HTTPS traffic to the proxy server instance. The security group is associated with the VPC specified in the VpcId parameter.

## Outputs

The template provides the following outputs:

* ProxyInstanceId: The ID of the proxy server instance.
* ProxyInstanceDNS: The public DNS name of the proxy server instance.

## Usage

To use this template, you'll need to provide the following:

* An existing EC2 KeyPair in your AWS account.
* The ID of the VPC where you want to deploy the proxy server.

You can then deploy the stack using the AWS CloudFormation console, CLI, or SDK.

After the stack is deployed, you can connect to the proxy server instance using SSH and test the proxy functionality.