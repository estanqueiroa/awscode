
import os.path

import aws_cdk as cdk

from aws_cdk import (
    aws_ec2 as ec2,
    aws_iam as iam,
    aws_lambda as _lambda,
    aws_events as events,
    aws_events_targets as targets,
    App, Stack
)

from constructs import Construct

dirname = os.path.dirname(__file__)

class SchedulerEC2LambdaStack(Stack):

    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)


########## STOP lambda ##################
        
        # Create Lambda function
        lambda_fn = _lambda.Function(
            self, "ShutdownEC2Lambda",
            runtime=_lambda.Runtime.PYTHON_3_10,
            handler="shutdown_ec2.lambda_handler",
            timeout = cdk.Duration.seconds(30),
            architecture = _lambda.Architecture.ARM_64, # AWS Graviton for cost optimization
            code=_lambda.Code.from_asset(os.path.join(dirname, "lambdas/shutdown_ec2.zip")),
            environment={
                "INSTANCE_ID": cdk.Fn.import_value('NATinstanceID') # import from VPC stack
            }
        )

        # Add permission for Lambda to stop EC2 instances
        lambda_fn.add_to_role_policy(
            statement=iam.PolicyStatement(
                actions=["ec2:StopInstances",
                "ec2:DescribeInstances",
                "ec2:CreateTags"],
                resources=["*"]
            )
        )

        # Run 9:00 PM UTC every Monday through Friday
        # See https://docs.aws.amazon.com/lambda/latest/dg/tutorial-scheduled-events-schedule-expressions.html

        # Create a scheduled CloudWatch rule to trigger the Lambda
        rule = events.Rule(
            self, "ScheduledRuleStop",
            schedule=events.Schedule.expression('cron(0 21 ? * MON-FRI *)')
        )

        rule.add_target(targets.LambdaFunction(lambda_fn))


########## START lambda ##################
        
        # Create Lambda function
        lambda_fn2 = _lambda.Function(
            self, "StartEC2Lambda",
            runtime=_lambda.Runtime.PYTHON_3_10,
            handler="start_ec2.lambda_handler",
            timeout = cdk.Duration.seconds(30),
            architecture = _lambda.Architecture.ARM_64, # AWS Graviton for cost optimization
            code=_lambda.Code.from_asset(os.path.join(dirname, "lambdas/start_ec2.zip")),
            environment={
                "INSTANCE_ID": cdk.Fn.import_value('NATinstanceID') # import from VPC stack
            }
        )

        # Add permission for Lambda to stop EC2 instances
        lambda_fn2.add_to_role_policy(
            statement=iam.PolicyStatement(
                actions=["ec2:StartInstances",
                "ec2:DescribeInstances",
                "ec2:CreateTags"],
                resources=["*"]
            )
        )

        # Run 10:00 AM UTC every Monday through Friday
        # See https://docs.aws.amazon.com/lambda/latest/dg/tutorial-scheduled-events-schedule-expressions.html

        # Create a scheduled CloudWatch rule to trigger the Lambda
        rule2 = events.Rule(
            self, "ScheduledRuleStart",
            schedule=events.Schedule.expression('cron(0 10 ? * MON-FRI *)')
        )

        rule2.add_target(targets.LambdaFunction(lambda_fn2))