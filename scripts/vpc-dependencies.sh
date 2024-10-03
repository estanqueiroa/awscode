# https://repost.aws/knowledge-center/troubleshoot-dependency-error-delete-vpc

export VPC_ID="vpc-095d3c6a963a8ea43"
export AWS_REGION="sa-east-1"

aws ec2 describe-internet-gateways --region $AWS_REGION --filters "Name=attachment.vpc-id,Values=$VPC_ID" | grep -i "InternetGatewayId"
aws ec2 describe-subnets --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "SubnetId"
aws ec2 describe-route-tables --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "RouteTableId"
aws ec2 describe-network-acls --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "NetworkAclId"
aws ec2 describe-vpc-peering-connections --region $AWS_REGION --filters "Name=requester-vpc-info.vpc-id,Values=$VPC_ID" | grep -i "VpcPeeringConnectionId"
aws ec2 describe-vpc-endpoints --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "VpcEndpointId"
aws ec2 describe-nat-gateways --region $AWS_REGION --filter "Name=vpc-id,Values=$VPC_ID" | grep -i "NatGatewayId"
aws ec2 describe-security-groups --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "GroupId"
aws ec2 describe-instances --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "InstanceId"
aws ec2 describe-vpn-gateways --region $AWS_REGION --filters "Name=attachment.vpc-id,Values=$VPC_ID" | grep -i "VpnGatewayId"
aws ec2 describe-network-interfaces --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "NetworkInterfaceId"
aws ec2 describe-carrier-gateways --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "CarrierGatewayId"
aws ec2 describe-local-gateway-route-table-vpc-associations --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "LocalGatewayRouteTableVpcAssociationId"