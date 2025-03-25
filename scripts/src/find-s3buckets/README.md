# Scan tool to identify open public S3 buckets

Run this script in your own account to identify potential misconfigured S3 buckets.

- Run `aws s3 ls` to get your account buckets list
- Update the bucket names in the script
- Run the script and check the output results
- Follow the security best practices for the identified open buckets

## Security best practices for Amazon S3

Amazon S3 provides a number of security features to consider as you develop and implement your own security policies.
The following best practices are general guidelines and don't represent a complete security solution.
Because these best practices might not be appropriate or sufficient for your environment, treat them as helpful recommendations rather than prescriptions.

[Security best practices for Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html)

- Disable access control lists (ACLs)
- Ensure that your Amazon S3 buckets use the correct policies and are not publicly accessible
- Implement least privilege access
- Use IAM roles for applications and AWS services that require Amazon S3 access
- Consider encryption of data at rest
- Enforce encryption of data in transit
- Consider using S3 Object Lock
- Enable S3 Versioning
- Consider using S3 Cross-Region Replication
- Consider using VPC endpoints for Amazon S3 access
- Use managed AWS security services to monitor data security

[Amazon S3 monitoring and auditing best practices](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html#security-best-practices-detect)

- Identify and audit all of your Amazon S3 buckets
- Implement monitoring by using AWS monitoring tools
- Enable Amazon S3 server access logging
- Use AWS CloudTrail
- Enable AWS Config
- Use S3 Storage Lens
- Monitor AWS security advisories

[Monitoring data security with managed AWS security services](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html#monitoring-data-security)

- Amazon GuardDuty
- Amazon Detective
- IAM Access Analyzer
- Amazon Macie
- AWS Security Hub

## To report an exposed S3 bucket to AWS, you can follow these official channels:

1. AWS Vulnerability Reporting Program:
   - Visit: https://aws.amazon.com/security/vulnerability-reporting/
   - Email: aws-security@amazon.com

2. AWS Security Contact Form:
   - Go to: https://hackerone.com/aws_vdp/
   - Click on "Submit report"

## When reporting, include:
- The bucket name
- Any evidence of public accessibility
- Screenshots (if applicable)
- How you discovered the exposure
- Your contact information
- The date you discovered the issue

## Important guidelines:
- DON'T download or modify any data
- DON'T share the bucket details publicly
- DON'T attempt to contact the bucket owner directly
- DO report it promptly
- DO be clear and professional in your report
- DO maintain confidentiality

**Remember**: Public access to an S3 bucket doesn't automatically mean it's a security issue - some buckets are intentionally public (like those hosting website content). Only report buckets that appear to be unintentionally exposed with sensitive content.

AWS will review the report and contact the bucket owner if necessary while maintaining your anonymity.