######
#
# Creates S3 Gateway endpoint in Default VPC and apply tags using Custom Resource
#
#

from aws_cdk import (
    aws_ec2 as ec2,
    custom_resources as cr,
        App, Stack
)

from constructs import Construct

class VpcEndpointTagsStack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # get VPC id
        vpc_default=ec2.Vpc.from_lookup(self, "VPC", is_default=True)

        vpc_endpoint = vpc_default.add_gateway_endpoint(
                    "S3Endpoint",
                    service=ec2.GatewayVpcEndpointAwsService("s3")
                )

        aws_custom_resource = cr.AwsCustomResource(self, "VpcEndpointTags",
                                            install_latest_aws_sdk=False,
                                            on_update={
                                                "action": "createTags",
                                                "service":"EC2",
                                                "parameters": {
                                                    "Resources": [
                                                        vpc_endpoint.vpc_endpoint_id
                                                    ],
                                                    "Tags": [
                                                        {
                                                            "Key": "Name",
                                                            "Value": "Cookie Monster"
                                                        },
                                                        {
                                                            "Key": "Kitchen",
                                                            "Value": "Cake Bakery"
                                                        }
                                                    ]
                                                },
                                                "physical_resource_id": cr.PhysicalResourceId.of(str(Stack.of(self).stack_id))
                                            },
                                            policy=cr.AwsCustomResourcePolicy.from_sdk_calls(
                                                resources=cr.AwsCustomResourcePolicy.ANY_RESOURCE
                                            )
                                            )