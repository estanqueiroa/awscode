import os.path

from aws_cdk.aws_s3_assets import Asset

import aws_cdk as cdk

from aws_cdk import (
    aws_ec2 as ec2,
    aws_iam as iam,
    CfnOutput as output,
    App, Stack
)

from constructs import Construct



dirname = os.path.dirname(__file__)


class EC2InstanceStack(Stack):

    def __init__(self, scope: Construct, id: str, **kwargs) -> None:
        super().__init__(scope, id, **kwargs)


        # // create VPC w/ public and private subnets in 1 AZ
        # // I am using 1 AZ because it's a demo.  In real life always use >=2


        # VPC
        vpc = ec2.Vpc(self, "VPC",
            max_azs = 1,
            nat_gateways=0,
            ip_addresses=ec2.IpAddresses.cidr("10.0.0.0/24"),
            subnet_configuration=[ec2.SubnetConfiguration(name="Public",cidr_mask=28,subnet_type=ec2.SubnetType.PUBLIC),ec2.SubnetConfiguration(subnet_type=ec2.SubnetType.PRIVATE_WITH_EGRESS,
name='Private',cidr_mask=28)],

        )

        # add VPC flow logs
        flowlog = ec2.FlowLog(self, "VPCFlowLogs",
            resource_type=ec2.FlowLogResourceType.from_vpc(vpc)
        )

        # AMI
        amzn_linux = ec2.MachineImage.latest_amazon_linux2023(
            edition=ec2.AmazonLinuxEdition.STANDARD,
            )

        # Instance Role and SSM Managed Policy
        role = iam.Role(self, "InstanceSSM", assumed_by=iam.ServicePrincipal("ec2.amazonaws.com"))

        role.add_managed_policy(iam.ManagedPolicy.from_aws_managed_policy_name("AmazonSSMManagedInstanceCore"))

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

        # Instance
        instance = ec2.Instance(self, "Instance-nat",
            instance_type=ec2.InstanceType("t3.small"),
            machine_image=amzn_linux,
            security_group = securitygroup,
            vpc = vpc,
            role = role,
            key_name="finance-teste",
            vpc_subnets = ec2.SubnetSelection(subnet_type=ec2.SubnetType.PUBLIC),
            # sourceDestCheck: false, // should be false for NAT instances
            # associatePublicIpAddress: true, // assigns public IPs to Subnets
            source_dest_check = False,
            associate_public_ip_address = True,
            require_imdsv2 = True # security best practice

            )
        
        # instance.metadata = {
        #   'checkov': {
        #     'skip': [
        #       {
        #         'id': 'CKV_AWS_88',
        #         'comment': 'Public IP address is required for NAT instance'
        #       }
        #     ]
        #   }
        # }

        # export instance id

        output(self, "NATinstanceID", value=instance.instance_id, export_name= "NATinstanceID")

        # Script in S3 as Asset
        asset = Asset(self, "Asset", path=os.path.join(dirname, "configure.sh"))
        local_path = instance.user_data.add_s3_download_command(
            bucket=asset.bucket,
            bucket_key=asset.s3_object_key
        )

        # Userdata executes script from S3
        instance.user_data.add_execute_file_command(
            file_path=local_path
            )
        asset.grant_read(instance.role)

        # Route all 0.0.0.0/0 traffic from private subnets to NAT instance

        (vpc.private_subnets[0]).add_route("NAT-route-0",
            router_id=instance.instance_id,
            router_type=ec2.RouterType.INSTANCE,
            destination_cidr_block="0.0.0.0/0"
        )

#######################################
# TESTING ONLY - you can comment section below 
# to avoid associated costs
# with EC2 instance and VPC endpoints
#######################################

        # Create EC2 Instance in private subnet for testing
        instance2 = ec2.Instance(self, "Instance-testing",
            instance_type=ec2.InstanceType("t3.small"),
            machine_image=amzn_linux,
            security_group = securitygroup,
            vpc = vpc,
            role = role,
            key_name="finance-teste",
            vpc_subnets = ec2.SubnetSelection(subnet_type=ec2.SubnetType.PRIVATE_WITH_EGRESS),
            require_imdsv2 = True

            )

        # add VPC endpoints for SSM in private subnet
        vpc.add_interface_endpoint("ssmvpce01", service=ec2.InterfaceVpcEndpointAwsService('ssm'),security_groups=[securitygroup])
        vpc.add_interface_endpoint("ssmvpce02", service=ec2.InterfaceVpcEndpointAwsService('ssmmessages'),security_groups=[securitygroup])
        vpc.add_interface_endpoint("ssmvpce03", service=ec2.InterfaceVpcEndpointAwsService('ec2messages'),security_groups=[securitygroup])

