# https://repost.aws/knowledge-center/troubleshoot-dependency-error-delete-vpc

export VPC_ID="vpc-0a2d150c2d1b2bc4a"
export AWS_REGION="us-east-1"

# Function to check if the output is empty and print "not found" if so
check_output() {
    if [ -z "$1" ]; then
        echo "not found"
    else
        echo "$1"
    fi
}

echo "Internet Gateways:"
check_output "$(aws ec2 describe-internet-gateways --region $AWS_REGION --filters "Name=attachment.vpc-id,Values=$VPC_ID" | grep -i "InternetGatewayId")"

echo "Subnets:"
check_output "$(aws ec2 describe-subnets --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "SubnetId")"

echo "Route Tables:"
check_output "$(aws ec2 describe-route-tables --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "RouteTableId")"

echo "Network ACLs:"
check_output "$(aws ec2 describe-network-acls --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "NetworkAclId")"

echo "VPC Peering Connections:"
check_output "$(aws ec2 describe-vpc-peering-connections --region $AWS_REGION --filters "Name=requester-vpc-info.vpc-id,Values=$VPC_ID" | grep -i "VpcPeeringConnectionId")"

echo "VPC Endpoints:"
check_output "$(aws ec2 describe-vpc-endpoints --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "VpcEndpointId")"

echo "NAT Gateways:"
check_output "$(aws ec2 describe-nat-gateways --region $AWS_REGION --filter "Name=vpc-id,Values=$VPC_ID" | grep -i "NatGatewayId")"

echo "Security Groups:"
check_output "$(aws ec2 describe-security-groups --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "GroupId")"

echo "EC2 Instances:"
check_output "$(aws ec2 describe-instances --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "InstanceId")"

echo "VPN Gateways:"
check_output "$(aws ec2 describe-vpn-gateways --region $AWS_REGION --filters "Name=attachment.vpc-id,Values=$VPC_ID" | grep -i "VpnGatewayId")"

echo "Network Interfaces:"
check_output "$(aws ec2 describe-network-interfaces --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "NetworkInterfaceId")"

echo "Carrier Gateways:"
check_output "$(aws ec2 describe-carrier-gateways --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "CarrierGatewayId")"

echo "Local Gateway Route Table VPC Associations:"
check_output "$(aws ec2 describe-local-gateway-route-table-vpc-associations --region $AWS_REGION --filters "Name=vpc-id,Values=$VPC_ID" | grep -i "LocalGatewayRouteTableVpcAssociationId")"
