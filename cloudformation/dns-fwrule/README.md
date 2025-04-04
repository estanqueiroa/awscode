# AWS Route 53 Resolver DNS Firewall Configuration

This CloudFormation template sets up DNS Firewall Rules for allowing and blocking traffic, and associates them with a VPC.

## Overview

This template creates:
1. An Allow List of domains
2. A Block List of domains
3. A DNS Firewall Rule Group
4. A VPC Association for the Rule Group

## Parameters

- `pListVpcs`: List of VPC IDs to associate with DNS Firewall Rule Group (comma-separated)
- `pManagedListId`: ID of AWS Managed Domain List (default: AWSManagedDomainsGlobalThreatList)

## Resources

### Allow List
- Type: `AWS::Route53Resolver::FirewallDomainList`
- Allows: google.com, amazon.com

### Block List
- Type: `AWS::Route53Resolver::FirewallDomainList`
- Blocks: malicious-domain.com, *.bad-domain.com

### DNS Firewall Rule Group
- Type: `AWS::Route53Resolver::FirewallRuleGroup`
- Rules:
  1. ALERT on Block List
  2. BLOCK (NODATA response) on AWS Managed List
  3. ALLOW on Allow List

### VPC Association
- Type: `AWS::Route53Resolver::FirewallRuleGroupAssociation`
- Associates the Rule Group with the specified VPC
- Priority: 110
- Mutation Protection: DISABLED

## Outputs

- `oDNSFirewallRuleGroupId`: ID of the DNS Firewall Rule Group
- `oAllowDomainListId`: ID of the Allow Domain List
- `oBlockDomainListId`: ID of the Block Domain List
- `oVPCAssociationId`: ID of the VPCs Association **Note** [Non-alphanumeric characters](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference-foreach-example-resource.html#intrinsic-function-reference-foreach-example-non-alphanumeric) are not supported in Output section (e.g. vpc-id)
- `oRuleGroupArn`: ARN of the DNS Firewall Rule Group

## Usage

1. Deploy this template in your AWS account.
2. Provide the VPC ID as a parameter.
3. Optionally, provide a different AWS Managed List ID.

## Important Notes

- This template will implement AWS services which may have associated costs.
- Use at your own risk and review the AWS pricing details.
- Mutation Protection is set to DISABLED. Consider enabling it after initial setup.

## Cleanup

- Delete CloudFormation stack to remove all the created resouces

## Troubleshooting

- VPC association may be stuck during Stack deletion if the `MutationProtection` setting is configured to "ENABLED"

If you face this issue, run this AWS CLI script to identify the VPC Association Ids:

```bash
aws route53resolver list-firewall-rule-group-associations \
  --query "FirewallRuleGroupAssociations[].[Id, MutationProtection]" \
  --output table
```

Then run this script for each VPC association to update `MutationProtection` to "DISABLED"

```bash
aws route53resolver update-firewall-rule-group-association \
  --firewall-rule-group-association-id your-association-id \
  --mutation-protection DISABLED
```

Then try to update/delete CloudFormation stack again.


## References

- [AWS Route 53 Resolver DNS Firewall Rule Settings](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-dns-firewall-rule-settings.html)
- [Amazon Route 53 Resolver DNS Firewall Automation Examples](https://github.com/aws-samples/amazon-route-53-resolver-dns-firewall-automation-examples)

## License

This template is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for specific language governing permissions and limitations under the License.
