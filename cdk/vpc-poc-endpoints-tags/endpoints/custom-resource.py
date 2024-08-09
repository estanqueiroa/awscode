###### TO BE TESTED ######

from aws_cdk import (
    aws_ec2 as ec2,
    custom_resources as cr,
    core
)

class VpcEndpointTagsStack(core.Stack):
    def __init__(self, scope: core.Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        vpc_endpoint = ec2.VpcEndpoint(self, "VpcEndpoint",
                                      vpc=ec2.Vpc.from_lookup(self, "VPC", is_default=True),
                                      service=ec2.InterfaceVpcEndpointService.find_by_service_name("com.amazonaws.us-east-1.s3"))

        aws_custom_resource = cr.AwsCustomResource(self, "VpcEndpointTags",
                                                  install_latest_aws_sdk=False,
                                                  on_update={
                                                      "action": "createTags",
                                                      "parameters": {
                                                          "Resources": [
                                                              vpc_endpoint.vpc_endpoint_id
                                                          ],
                                                          "Tags": [
                                                              {
                                                                  "Key": "Name",
                                                                  "Value": "Cookie Monster"
                                                              }
                                                          ]
                                                      },
                                                      "physicalResourceId": cr.PhysicalResourceId.of(str(core.Stack.of(self).stack_id))
                                                  },
                                                  policy=cr.AwsCustomResourcePolicy.from_sdk_calls(
                                                      resources=cr.AwsCustomResourcePolicy.ANY_RESOURCE
                                                  )
                                                  )