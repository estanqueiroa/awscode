#!/usr/bin/env python3
import os.path

import aws_cdk as cdk

from endpoints.endpoints_stack import EndpointsStack

app = cdk.App()

EndpointsStack(app, "EndpointsStack",
    # If you don't specify 'env', this stack will be environment-agnostic.
    # Account/Region-dependent features and context lookups will not work,
    # but a single synthesized template can be deployed anywhere.

    # Uncomment the next line to specialize this stack for the AWS Account
    # and Region that are implied by the current CLI configuration.

    #env=cdk.Environment(account=os.getenv('CDK_DEFAULT_ACCOUNT'), region=os.getenv('CDK_DEFAULT_REGION')),

    # Uncomment the next line if you know exactly what Account and Region you
    # want to deploy the stack to. */

    #env=cdk.Environment(account='123456789012', region='us-east-1'),

    # For more information, see https://docs.aws.amazon.com/cdk/latest/guide/environments.html
    )

dirname = os.path.dirname(__file__)

cdk.Tags.of(app).add("PROJECT", dirname) # add tags to the entire app (all resources created by this app)

# Add multiple tags to all resources
tags = {'Key1': 'Value1', 'Key2': 'Value2', 'Key3':'Value3', 'Key4':'Value4', 'Key5':'Value5','Key6':'Value6'}
for key, value in tags.items():
    cdk.Tags.of(app).add(key, value)

app.synth()
