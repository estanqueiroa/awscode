# Folder /cloudformation/bday

Template file: bday.yaml

Description: "Birthday reminder app to Notify Via Email on daily basis"

WARNING: This solution will implement AWS services which may have associated costs - USE AT YOUR OWN RISK :-)

AWS Services to be created: SNS, Lambda, IAM role, EventBridge, DynamoDB table.

![Alt text](../diagrams/bday.png?raw=true "Diagram Image")

# How It Works

After solution deployment (steps below), you can manually add the birthday records into the DynamoDB table using the following format:

Name - free text

Bdate - year-month-day (e.g 1981-02-24)

The Lambda function will scan the records every day (as per the configured EventBridge schedule) and verify which records match with the current date, sending then an email notification to the subscribed email address.

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
| Amazon DynamoDB | https://aws.amazon.com/dynamodb/  |
| Amazon EventBridge  | https://aws.amazon.com/eventbridge/ |
| AWS Lambda | https://aws.amazon.com/lambda/ |
| Amazon Elastic Block Store (EBS)  | https://aws.amazon.com/ebs/ |
| Amazon SNS | https://aws.amazon.com/sns/|


# Estimated Costs

The cost estimation for each solution is presented below **(CAUTION: costs may vary considering your use case)**

- AWS Region: US East (N. Virginia)

- Monthly cost: 0.25 USD

- Total 12 months cost: 3.00 USD


https://calculator.aws/#/estimate?id=2c9436e8bb220a3a97af2c3a645df70b7da08887

# Cleaning Up

Delete CloudFormation stack for resources termination/deletion.

# Next Steps

1) Birthday app - include math to calculate people ages.
