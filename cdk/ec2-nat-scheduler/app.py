#!/usr/bin/env python3

import os.path

import aws_cdk as cdk

from EC2VPC_stack import EC2InstanceStack

from Scheduler_stack import SchedulerEC2LambdaStack


dirname = os.path.dirname(__file__)

app = cdk.App()

EC2InstanceStack(app, "sme-VPC-EC2-cdk")

SchedulerEC2LambdaStack(app, "sme-SchedulerEC2Lambda-cdk")

cdk.Tags.of(app).add("PROJECT", dirname) # add tags to the entire app (all resources created by this app)

app.synth()
