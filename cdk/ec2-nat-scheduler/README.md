# SME Program

The complexity of the artifact should be 300-level or above.

https://w.amazon.com/bin/view/AWS/Teams/Proserve/CIA/SharedDeliveryTeam/SME_Program/IaC/Artifacts


CDK: Model the app through constructs not app, the entire build should be deterministic (use AWS SSM or Secret Manager for sensitive values).

https://docs.aws.amazon.com/cdk/v2/guide/constructs.html#constructs_lib

# NAT basics

You can use a NAT device to allow resources in private subnets to connect to the internet, other VPCs, or on-premises networks. These instances can communicate with services outside the VPC, but they cannot receive unsolicited connection requests.

https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html#basics

*Types of NAT devices:*

* A NAT gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that instances in a private subnet can connect to services outside your VPC but external services cannot initiate a connection with those instances.

* A NAT instance provides network address translation (NAT). You can use a NAT instance to allow resources in a private subnet to communicate with destinations outside the virtual private cloud (VPC), such as the internet or an on-premises network. The resources in the private subnet can initiate outbound IPv4 traffic to the internet, but they can't receive inbound traffic initiated on the internet.

Here you can compare NAT gateways vs NAT instances: https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-comparison.html

# Create EC2 NAT Instance for Low Budget projects

Tipically, NAT gateways are recommended because they provide better availability and bandwidth and require less effort on your part to administer. However, they can cost around $80 minimum per month, much more than running NAT instances (~$8/month depending on instance type), what can be a roadblock for small business and/or startups. You can also reduce the NAT instance running costs when scheduling stop/start triggers outside business hours and weekends, if not in use. Another cost reduction option is to apply EC2 Instance Saving Plans.

That being said, the proposed solution is to implement NAT instance(s) using AWS CDK with the lowest cost as possible.

Considering the AWS NAT AMI is no longer available since it is built on the last version of the Amazon Linux AMI, 2018.03, which reached the end of standard support on December 31, 2020 and end of maintenance support on December 31, 2023, now you must create your own NAT AMI from a current version of Amazon Linux.

NAT AMI: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_NAT_Instance.html#create-nat-ami


![Alt text](../diagrams/nat-instance.png?raw=true "Diagram Image")

This solution includes:

* Own VPC with public subnet with EC2 NAT instance and private subnet (with EC2 instance only for testing purpose).
* EC2 instances based on latest Amazon Linux 2.
* (Optional) System Manager Session Manager replaces SSH (Remote session available trough the AWS Console or the AWS CLI). You can remove SSM VPC endpoints for cost saving and instead use key pair to connect to EC2 instances.
* Userdata executed from script in S3 (`configure.sh`).
* Lambda functions to stop/start EC2 NAT instance outside business hours for cost saving.

## Requirements

* Provide existing EC2 key pair name in the filename *EC2VPC_stack.py*;
* After deployment and testing, comment testing code block in the filename *EC2VPC_stack.py* to avoid unnecessary costs with EC2 instance and VPC SSM endpoints;
* Configure your required schedule CRON in the filename  *Scheduler_stack.py* for lambdas start/stop executions.

## Useful commands

 * `cdk bootstrap`   initialize assets before deploy
 * `cdk synth`       emits the synthesized CloudFormation template
 * `cdk deploy`      deploy this stack to your default AWS account/region
 * `cdk diff`        compare deployed stack to this new version
 * `cdk list`        Lists the stacks in the app
 * `cdk destroy`     destroy this stack

 ## Testing

Connect to EC2 testing instance using AWS Systems Manager Session Manager (EC2 console "Connect") or EC2 key pair and try to ping any responsive website.

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/session-manager-to-linux.html

If there is a response like screen below, the request is being handled successfully by NAT instance. Otherwise, please check the "Troubleshooting" section.

![Alt text](../diagrams/testing.png?raw=true "Diagram Image")

IMPORTANT: After testing is completed, you can comment testing code block in the filename *EC2VPC_stack.py* to remove EC2 testing instance and VPC SSM endpoints in order to avoid any associated costs.

 ## EC2 instance scheduler

Included on this solution - How to automatically stop and start my Amazon Elastic Compute Cloud (Amazon EC2) instances to reduce my Amazon EC2 usage.

https://repost.aws/knowledge-center/start-stop-lambda-eventbridge

Two tag keys will be added to EC2 NAT instance by Lambda function with values to identify when it was stopped/started:

* Tag Key: LastStopDateTime

* Tag Key: LastStartDateTime

## Code scanning

https://www.checkov.io/7.Scan%20Examples/CDK.html


Run the `cdk synth` command to generate a CloudFormation template and scan it

`checkov -f cdk.out/AppStack.template.json`

`checkov -d cdk.out --skip-path cdk.out/skipfolder`

## Troubleshooting

Error Node JS when running `cdk ls`

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!                                                                            !!
!!  Node 16 has reached end-of-life on 2023-09-11 and is not supported.       !!
!!  Please upgrade to a supported node version as soon as possible.           !!
!!                                                                            !!
!!  This software is currently running on node v16.15.1.                
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

`nvm install 18.12.0`

`nvm use 18.12.0`

=======================================================

PING command not responding:

a) Check EC2 NAT instance is up and running on AWS console.

b) Check EC2 NAT instance service iptables status: 

`systemctl status iptables`







