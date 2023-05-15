# Folder /cloudformation/config

Template file: config-query.yaml

Description: "Birthday reminder app to Notify Via Email on daily basis"

WARNING: This solution will implement AWS services which may have associated costs - USE AT YOUR OWN RISK :-)

AWS Services to be created: Config.

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

# How It Works

You can use AWS Config for inventory purpose, to query the current configuration state of AWS resources based on configuration properties for a single account and Region or across multiple accounts and Regions. You can perform ad hoc, property-based queries against current AWS resource state metadata across a list of resources that AWS Config supports.


https://docs.aws.amazon.com/config/latest/developerguide/querying-AWS-resources.html


This CFN template creates a query to generate a report that lists EC2 information containing: AWS Account ID, EC2 Name and Private IP.


After CFN template is deployed to a new stack, you can access the created query through this AWS console link (change it according the AWS region you are using):

https://sa-east-1.console.aws.amazon.com/config/home?region=sa-east-1#/queries


Query scope can be:

- this account and region only
- ConfigAggregator for multiple accounts / Organizations

Click on RUN to execute query. You can export the output as JSON or CSV file.

![Alt text](../diagrams/query-scope.jpg?raw=true "Diagram Image")


# Related AWS Services

| AWS Service  | Product Page |
| ------------- | ------------- |
| Amazon Config | https://aws.amazon.com/config/  |

# AWS Workshop

https://mng.workshop.aws/config/advanced/advancedquery.html


# Estimated Costs

The advanced query feature is available at no additional cost to AWS Config customers in the AWS Regions listed here. For more information about AWS Config and the advanced query feature, see the AWS Config webpage and the AWS Config Developer Guide.

https://aws.amazon.com/about-aws/whats-new/2020/12/aws-config-advanced-query-feature-adds-support-saving-queries/

# Cleaning Up

Delete CloudFormation stack for resources termination/deletion.

# Next Steps

N/A