# aws cli associate resolver rule

# Disclaimer: This script is provided as-is, without any warranty or support. Users are responsible for testing and implementing the script in their own environments.
#
#  associate an existing Route53 Resolver rule with a specific VPC (Virtual Private Cloud) 
#

# !/bin/bash

# Set the necessary variables
RESOLVER_RULE_NAME="my-resolver-rule"
VPC_ID="vpc-0123456789abcdef"
 
# Get the resolver rule ID
RESOLVER_RULE_ID=$(aws route53resolver list-resolver-rules \
  --query "ResolverRules[?Name=='$RESOLVER_RULE_NAME'].Id" \
  --output text)
 
# Associate the VPC ID with the resolver rule
aws route53resolver associate-resolver-rule \
  --resolver-rule-id $RESOLVER_RULE_ID \
  --vpc-id $VPC_ID
 
# Verify the associated VPC
aws route53resolver get-resolver-rule \
  --resolver-rule-id $RESOLVER_RULE_ID \
  --query "ResolverRule.TargetIps[].VPCId" \
  --output text