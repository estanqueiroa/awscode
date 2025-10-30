

       _               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By Prisma Cloud | version: 3.2.470 
Update available 3.2.470 -> 3.2.489
Run pip3 install -U checkov to update 


terraform scan results:

Passed checks: 22, Failed checks: 0, Skipped checks: 3

Check: CKV_AWS_358: "Ensure AWS GitHub Actions OIDC authorization policies only allow safe claims and claim order"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/iam-358
Check: CKV_AWS_108: "Ensure IAM policies does not allow data exfiltration"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-do-not-allow-data-exfiltration
Check: CKV_AWS_49: "Ensure no IAM policies documents allow "*" as a statement's actions"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-iam-43
Check: CKV_AWS_107: "Ensure IAM policies does not allow credentials exposure"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-do-not-allow-credentials-exposure
Check: CKV_AWS_283: "Ensure no IAM policies documents allow ALL or any AWS principal permissions to the resource"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-283
Check: CKV_AWS_1: "Ensure IAM policies that allow full "*-*" administrative privileges are not created"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/iam-23
Check: CKV_AWS_110: "Ensure IAM policies does not allow privilege escalation"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-does-not-allow-privilege-escalation
Check: CKV_AWS_227: "Ensure KMS key is enabled"
	PASSED for resource: module.aws_budget.aws_kms_key.sns_encryption[0]
	File: /modules/budget/kms.tf:9-20
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/ensure-aws-key-management-service-kms-key-is-enabled
Check: CKV_AWS_33: "Ensure KMS key policy does not contain wildcard (*) principal"
	PASSED for resource: module.aws_budget.aws_kms_key.sns_encryption[0]
	File: /modules/budget/kms.tf:9-20
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-kms-key-policy-does-not-contain-wildcard-principal
Check: CKV_AWS_7: "Ensure rotation for customer created CMKs is enabled"
	PASSED for resource: module.aws_budget.aws_kms_key.sns_encryption[0]
	File: /modules/budget/kms.tf:9-20
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/logging-8
Check: CKV_AWS_358: "Ensure AWS GitHub Actions OIDC authorization policies only allow safe claims and claim order"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/iam-358
Check: CKV_AWS_108: "Ensure IAM policies does not allow data exfiltration"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-do-not-allow-data-exfiltration
Check: CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-do-not-allow-write-access-without-constraint
Check: CKV_AWS_49: "Ensure no IAM policies documents allow "*" as a statement's actions"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-iam-43
Check: CKV_AWS_107: "Ensure IAM policies does not allow credentials exposure"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-do-not-allow-credentials-exposure
Check: CKV_AWS_356: "Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-356
Check: CKV_AWS_109: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-do-not-allow-permissions-management-resource-exposure-without-constraint
Check: CKV_AWS_283: "Ensure no IAM policies documents allow ALL or any AWS principal permissions to the resource"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-283
Check: CKV_AWS_1: "Ensure IAM policies that allow full "*-*" administrative privileges are not created"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/iam-23
Check: CKV_AWS_110: "Ensure IAM policies does not allow privilege escalation"
	PASSED for resource: module.aws_budget.aws_iam_policy_document.sns_topic_policy
	File: /modules/budget/sns.tf:32-92
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-does-not-allow-privilege-escalation
Check: CKV_AWS_26: "Ensure all data stored in the SNS topic is encrypted"
	PASSED for resource: module.aws_budget.aws_sns_topic.cost_anomaly_updates[0]
	File: /modules/budget/sns.tf:9-18
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/general-15
Check: CKV_AWS_41: "Ensure no hard coded AWS access key and secret key exists in provider"
	PASSED for resource: aws.default
	File: /providers.tf:10-22
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/secrets-policies/bc-aws-secrets-5
Check: CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
	SKIPPED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	Suppress comment: This is KMS resource policy and hence using '*' for resources
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-do-not-allow-write-access-without-constraint
Check: CKV_AWS_356: "Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions"
	SKIPPED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	Suppress comment: This is KMS resource policy and hence using '*' for resources
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/bc-aws-356
Check: CKV_AWS_109: "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
	SKIPPED for resource: module.aws_budget.aws_iam_policy_document.cmk_policy
	Suppress comment: This is KMS resource policy and hence using '*' for resources
	File: /modules/budget/kms.tf:31-98
	Calling File: /main.tf:9-29
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-iam-policies/ensure-iam-policies-do-not-allow-permissions-management-resource-exposure-without-constraint

