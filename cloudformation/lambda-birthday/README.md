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

3) Email address to receive the notification (you need to confirm the subscription clicking on the link sent to your email)

Subject: AWS Notification - Subscription Confirmation

You have chosen to subscribe to the topic: 
arn:aws:sns:aws-region:accountid:Birthday-App-Reminder
To confirm this subscription, click or visit the link below (If this was in error no action is necessary): Confirm subscription


4) Create CloudFormation (CFN) stack using YAML solution templates.

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
| Amazon SNS | https://aws.amazon.com/sns/|


# Estimated Costs

The cost estimation for each solution is presented below **(CAUTION: costs may vary considering your use case)**

- AWS Region: US East (N. Virginia)

- Monthly cost: 0.25 USD

- Total 12 months cost: 3.00 USD

https://calculator.aws/#/estimate?id=2c9436e8bb220a3a97af2c3a645df70b7da08887

Depending on the usage, AWS Lambda, Amazon SNS and Amazon DynamoDB may fall into Always Free pricing tier: https://aws.amazon.com/free/

# (Optional) Import CSV into existing DynamoDB table

This CloudFormation template "dynamodb-import-csv.yaml" is designed to import data from a CSV file stored in an Amazon S3 bucket into a DynamoDB table.

Parameters:

* S3BucketName: The name of the S3 bucket containing the CSV file.
* S3FileName: The name of the CSV file in the S3 bucket.
* DynamoDBTableName: The name of the DynamoDB table to import the data into.

When the CloudFormation stack is created or updated, the CustomResource triggers the LambdaFunction.

# Cleaning Up

Delete CloudFormation stack(s) for resources termination/deletion.

# Next Steps

1) Include math to calculate people ages. DONE in new version
2) Automate records management.
