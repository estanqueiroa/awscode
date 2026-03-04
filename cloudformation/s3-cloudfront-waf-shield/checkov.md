

       _               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By Prisma Cloud | version: 3.2.500 
Update available 3.2.500 -> 3.2.506
Run pip3 install -U checkov to update 


cloudformation scan results:

Passed checks: 12, Failed checks: 0, Skipped checks: 2

Check: CKV_AWS_19: "Ensure the S3 bucket has server-side-encryption enabled"
	PASSED for resource: AWS::S3::Bucket.rS3Bucket
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/s3-14-data-encrypted-at-rest
Check: CKV_AWS_20: "Ensure the S3 bucket does not allow READ permissions to everyone"
	PASSED for resource: AWS::S3::Bucket.rS3Bucket
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/s3-1-acl-read-permissions-everyone
Check: CKV_AWS_53: "Ensure S3 bucket has block public ACLs enabled"
	PASSED for resource: AWS::S3::Bucket.rS3Bucket
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/bc-aws-s3-19
Check: CKV_AWS_57: "Ensure the S3 bucket does not allow WRITE permissions to everyone"
	PASSED for resource: AWS::S3::Bucket.rS3Bucket
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/s3-2-acl-write-permissions-everyone
Check: CKV_AWS_54: "Ensure S3 bucket has block public policy enabled"
	PASSED for resource: AWS::S3::Bucket.rS3Bucket
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/bc-aws-s3-20
Check: CKV_AWS_21: "Ensure the S3 bucket has versioning enabled"
	PASSED for resource: AWS::S3::Bucket.rS3Bucket
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/s3-16-enable-versioning
Check: CKV_AWS_55: "Ensure S3 bucket has ignore public ACLs enabled"
	PASSED for resource: AWS::S3::Bucket.rS3Bucket
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/bc-aws-s3-21
Check: CKV_AWS_56: "Ensure S3 bucket has RestrictPublicBuckets enabled"
	PASSED for resource: AWS::S3::Bucket.rS3Bucket
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/bc-aws-s3-22
Check: CKV_AWS_34: "Ensure CloudFront Distribution ViewerProtocolPolicy is set to HTTPS"
	PASSED for resource: AWS::CloudFront::Distribution.rCloudFrontDistribution
	File: /s3-cloudfront-waf-shield.yml:140-218
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/networking-32
Check: CKV_AWS_174: "Verify CloudFront Distribution Viewer Certificate is using TLS v1.2 or higher"
	PASSED for resource: AWS::CloudFront::Distribution.rCloudFrontDistribution
	File: /s3-cloudfront-waf-shield.yml:140-218
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/bc-aws-networking-63
Check: CKV_AWS_68: "CloudFront Distribution should have WAF enabled"
	PASSED for resource: AWS::CloudFront::Distribution.rCloudFrontDistribution
	File: /s3-cloudfront-waf-shield.yml:140-218
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-general-policies/bc-aws-general-27
Check: CKV_AWS_192: "Ensure WAF prevents message lookup in Log4j2. See CVE-2021-44228 aka log4jshell"
	PASSED for resource: AWS::WAFv2::WebACL.rWafWebAcl
	File: /s3-cloudfront-waf-shield.yml:241-325
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-networking-policies/ensure-waf-prevents-message-lookup-in-log4j2
Check: CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
	SKIPPED for resource: AWS::S3::Bucket.rS3Bucket
	Suppress comment: access logging not required
	File: /s3-cloudfront-waf-shield.yml:91-107
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/s3-policies/s3-13-enable-logging
Check: CKV_AWS_86: "Ensure CloudFront Distribution has Access Logging enabled"
	SKIPPED for resource: AWS::CloudFront::Distribution.rCloudFrontDistribution
	Suppress comment: access logging not required
	File: /s3-cloudfront-waf-shield.yml:140-218
	Guide: https://docs.prismacloud.io/en/enterprise-edition/policy-reference/aws-policies/aws-logging-policies/logging-20

