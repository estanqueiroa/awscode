# Folder /cloudformation/rds

Template file: rds-scheduler.yaml

Description: "Stop and start Amazon RDS instances at regular intervals using Lambda based on TAG"

WARNING: This solution will implement AWS services which may have associated costs - USE AT YOUR OWN RISK :-)

AWS Services to be created: Lambda, IAM role, EventBridge.

![Alt text](../diagrams/rds-scheduler.png?raw=true "Diagram Image")

# Short Description

To reduce the overall cost, Amazon RDS allows instances to be stopped temporarily. While the instance is stopped, you’re charged for storage and backups, but not for the DB instance hours. Please note that a stopped instance will automatically be started after 7 days.

You can use AWS Lambda and Amazon EventBridge to automatically stop and start RDS instances based on tag to save running costs.

Note: The following resolution is a simple solution based on this blog https://aws.amazon.com/blogs/database/schedule-amazon-rds-stop-and-start-using-aws-lambda/

For a more advanced solution, use the AWS Instance Scheduler. For more information, please see https://docs.aws.amazon.com/solutions/latest/instance-scheduler-on-aws/solution-overview.html

# How It Works

Tag the in-scope RDS instances with:

** case sensitive **
Tag Key = DEV-TEST
Tag Value = Auto-Shutdown

After solution deployment (steps below), AWS Lambda function and Amazon EventBridge will automatically stop and start the tagged RDS instances on the scheduled time.

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

# To add a tag to a RDS instance


You must have the AWS CLI installed and configured: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

Unless otherwise stated, all examples have unix-like quotation rules. These examples will need to be adapted to your terminal’s quoting rules.

```
aws rds add-tags-to-resource \
    --resource-name arn:aws:rds:us-east-1:123456789012:db:database-mysql \
    --tags "[{\"Key\": \"DEV-TEST\",\"Value\": \"Auto-Shutdown\"}]"
```

For more info, please check here: https://docs.aws.amazon.com/cli/latest/reference/rds/add-tags-to-resource.html


# Related AWS Services

| AWS Service  | Product Page |
| ------------- | ------------- |
| Amazon EventBridge  | https://aws.amazon.com/eventbridge/ |
| AWS Lambda | https://aws.amazon.com/lambda/ |
| Amazon Elastic Block Store (EBS)  | https://aws.amazon.com/ebs/ |
| Amazon Elastic Relational Database Service (RDS)  | https://aws.amazon.com/rds/ |


# Estimated Costs

The cost estimation for each solution is presented below **(CAUTION: costs may vary considering your use case)**

- AWS Region: US East (N. Virginia)

- Monthly cost: 0.25 USD

- Total 12 months cost: 3.00 USD


https://calculator.aws/#/estimate?id=2c9436e8bb220a3a97af2c3a645df70b7da08887

# Cleaning Up

Delete CloudFormation stack for resources termination/deletion.

# Next Steps

N/A
