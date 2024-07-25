# Top 5 AWS Service Costs Monitoring

This CloudFormation template creates an AWS Lambda function, an SNS topic, and a CloudWatch Alarm to monitor and notify you about the top 5 highest cost AWS services for your account.

## Prerequisites

Before you can create an alarm for your estimated charges, you must enable billing alerts, so that you can monitor your estimated AWS charges and create an alarm using billing metric data. After you enable billing alerts, you can't disable data collection, but you can delete any billing alarms that you created.

After you enable billing alerts for the first time, it takes about 15 minutes before you can view billing data and set billing alarms.

For more information, see the [AWS documentation on monitoring estimated charges with CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html).

## Resources

The CloudFormation template creates the following resources:

* SNS Topic: An SNS topic that will be used to send the billing alarm notifications.
* Billing Alarm: A CloudWatch alarm that monitors the EstimatedCharges metric and triggers when the estimated charges exceed the specified threshold.
* Lambda Execution Role: An IAM role with the necessary permissions for the Lambda function to access the Cost Explorer API and publish to the SNS topic.
* Lambda Function: A Lambda function that retrieves the top 5 highest cost AWS services for the current billing period and sends a notification to the SNS topic.
* EventBridge Rule: A CloudWatch Events rule that triggers the Lambda function on a schedule (default is daily at 11 PM GMT).

## Configuration Parameters

The template accepts the following configuration parameters:

* pEmail: The email address to receive the billing alarm notifications.
* pAlarmThreshold: The threshold of estimated charges in USD that will trigger the billing alarm.
* pScheduleEvent: The schedule for the Lambda function to run (default is daily at 11 PM GMT).

## Outputs

The template provides the following output:

* oTopCostLambdaFunctionArn: The ARN of the top 5 AWS service costs Lambda function.

## Deployment

To deploy this CloudFormation template, you can use the AWS Management Console, AWS CLI, or AWS SDK. Here's an example of how to deploy it using the AWS CLI:

```bash
aws cloudformation create-stack \
  --stack-name top-5-aws-service-costs \
  --template-body file://costs-monitor.yml \
  --parameters ParameterKey=pEmail,ParameterValue=your_email@example.com \
               ParameterKey=pAlarmThreshold,ParameterValue=200 \
               ParameterKey=pScheduleEvent,ParameterValue="cron(0 23 * * ? *)"
```

Replace your_email@example.com with the email address you want to receive the billing alarm notifications.

## Sample Notification

Sample email message:

```bash
From: AWS Notifications <no-reply@sns.amazonaws.com> 
Sent: Thursday, July 25, 2024 12:53 PM
To: your_email@example.com
Subject: Top 5 AWS Costs Notification - Account: 123456789012

Top 5 AWS Costs in the last 30 days:
Amazon SageMaker: $139.38
EC2 - Other: $41.09
Amazon ElastiCache: $32.11
Amazon Virtual Private Cloud: $21.08
Amazon QuickSight: $17.44
```


## Security Considerations

This CloudFormation template uses the principle of least privilege to grant the Lambda function the necessary permissions to perform its tasks. However, it's important to review the IAM permissions and adjust them as needed to align with your security requirements.

Additionally, the template includes some Checkov suppressions to disable certain security checks. It's recommended to review these suppressions and ensure they are appropriate for your use case.