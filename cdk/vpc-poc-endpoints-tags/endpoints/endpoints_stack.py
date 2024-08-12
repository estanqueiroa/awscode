######
#
# Example on how to create multiple VPC endpoints (with no tagging - see the Custom Resource python file for tagging)
#

from aws_cdk.aws_s3_assets import Asset

import aws_cdk as cdk

from aws_cdk import (
    aws_ec2 as ec2,
    aws_iam as iam,
    CfnOutput as output,
    App, Stack
)

from constructs import Construct



class EndpointsStack(Stack):

    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)


        # Create a VPC
        vpc = ec2.Vpc(self, "VPC",
            nat_gateways=0,
            max_azs=2,  # Default is all AZs in region
            ip_addresses=ec2.IpAddresses.cidr("10.0.0.0/24"),
            subnet_configuration=[ec2.SubnetConfiguration(name="Public",cidr_mask=28,subnet_type=ec2.SubnetType.PUBLIC),ec2.SubnetConfiguration(subnet_type=ec2.SubnetType.PRIVATE_WITH_EGRESS,
                name='Private',cidr_mask=28)],

        )

        # create security group

        securitygroup = ec2.SecurityGroup(self, "SecurityGroup",
            vpc=vpc,
            description="Allow NAT access to ec2 instances",
            allow_all_outbound=True
        )

        # get VPC CIDR block for SGRP rules

        cidr = vpc.vpc_cidr_block

        # This will add the rule as an external cloud formation construct
        securitygroup.add_ingress_rule(ec2.Peer.ipv4(cidr), ec2.Port.tcp(22), "allow ssh access from the VPC")
        securitygroup.add_ingress_rule(ec2.Peer.ipv4(cidr), ec2.Port.tcp(80), "allow http access from the VPC")
        securitygroup.add_ingress_rule(ec2.Peer.ipv4(cidr), ec2.Port.tcp(443), "allow https access from the VPC")
        securitygroup.add_ingress_rule(ec2.Peer.ipv4(cidr), ec2.Port.all_icmp(), "allow icmp access from the VPC")

        # METHOD 1 - create using FOR LOOP
        # Define the list of services you want to create VPC Endpoints for
        if_services = [
            "ecr.api",
            "ecr.dkr",
            "logs",
            "kms"
        ]

        # # Create Interface VPC Endpoints using a for loop
        for if_service in if_services:
            
            vpc.add_interface_endpoint(if_service,
                                    service=ec2.InterfaceVpcEndpointAwsService(if_service),
                                    security_groups=[securitygroup]
                                    )

        # METHOD 2 - create individual per line
        # # add VPC endpoints for SSM in private subnet
        vpc.add_interface_endpoint("ssmvpce01", service=ec2.InterfaceVpcEndpointAwsService('ssm'),security_groups=[securitygroup]) # default private subnets
        vpc.add_interface_endpoint("ssmvpce02", service=ec2.InterfaceVpcEndpointAwsService('ssmmessages'),security_groups=[securitygroup]) # default private subnets
        vpc.add_interface_endpoint("ssmvpce03", service=ec2.InterfaceVpcEndpointAwsService('ec2messages'),security_groups=[securitygroup]) # default private subnets

        # Define the list of services you want to create VPC Endpoints for
        gw_services = [
            "dynamodb",
            "s3"
        ]

        # Create Gateway VPC Endpoints using a for loop
        for gw_service in gw_services:

            vpc.add_gateway_endpoint(gw_service,
                                    service=ec2.GatewayVpcEndpointAwsService(gw_service)
                             )

        # (Optional) Output the VPC ID
        output(self, "VpcId",
            value=vpc.vpc_id,
            description="The ID of the VPC"
        )



