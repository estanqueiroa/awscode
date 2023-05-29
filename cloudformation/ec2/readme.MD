# Folder /cloudformation/ec2

Template file: ec2-timer.yaml

Description: "Stop and start Amazon EC2 instances at regular intervals using Lambda"

WARNING: This solution will implement AWS services which may have associated costs - USE AT YOUR OWN RISK :-)

AWS Services to be created: Lambda, IAM role, EventBridge.

![Alt text](../diagrams/ec2-timer.png?raw=true "Diagram Image")

# Short Description

You can use AWS Lambda and Amazon EventBridge to automatically stop and start EC2 instances and save running costs.

Note: The following resolution is a simple solution based on this post https://repost.aws/knowledge-center/start-stop-lambda-eventbridge

For a more advanced solution, use the AWS Instance Scheduler. For more information, please see https://docs.aws.amazon.com/solutions/latest/instance-scheduler-on-aws/solution-overview.html

# How It Works

After solution deployment (steps below), AWS Lambda function and Amazon EventBridge will automatically stop and start EC2 instances on the scheduled time.

# Prerequisites

1) An Amazon Web Services (AWS) account with privileges to deploy AWS components listed on the solutions.

https://catalog.workshops.aws/cfn101/en-US/prerequisites/account

2) (Optional) Install and configure the AWS CLI version 2 

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

3) Create CloudFormation (CFN) stack using YAML solution templates.

Using AWS Console:

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-stack.html


Using AWS CLI:

```
aws cloudformation create-stack \
  --stack-name myteststack \
  --template-body file:///home/testuser/mytemplate.yaml
```

# Related AWS Services

| AWS Service  | Product Page |
| ------------- | ------------- |
| Amazon EventBridge  | https://aws.amazon.com/eventbridge/ |
| AWS Lambda | https://aws.amazon.com/lambda/ |
| Amazon Elastic Block Store (EBS)  | https://aws.amazon.com/ebs/ |


# Estimated Costs

The cost estimation for each solution is presented below **(CAUTION: costs may vary considering your use case)**

- AWS Region: US East (N. Virginia)

- Monthly cost: 0.25 USD

- Total 12 months cost: 3.00 USD


https://calculator.aws/#/estimate?id=2c9436e8bb220a3a97af2c3a645df70b7da08887

# Cleaning Up

Delete CloudFormation stack for resources termination/deletion.

# Next Steps

1) Allow multiple EC2 instances as parameter
2) Include tags to filter EC2 instances to be started / stopped.
