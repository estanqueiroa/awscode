# Folder /cloudformation/ekswaf

Template file: eksalbwaf.yaml

Description: "A template for CloudFront distribution using ALB and protected by WAF Global and Regional"

WARNING: This solution will implement AWS services which may have associated costs - USE AT YOUR OWN RISK :-)

AWS Services to be created: CloudFront, WAF web ACL, CloudWatch Log group.

![Alt text](./diagrams/eks-waf.png?raw=true "Diagram Image")

Based on this AWS answer: https://repost.aws/knowledge-center/waf-restrict-alb-allow-cloudfront

# How It Works

After solution deployment using AWS console or CloudFormation template (steps below), you can test application access using CloudFront domain URL.

# Prerequisites

1) An Amazon Web Services (AWS) account with privileges to deploy AWS components listed on the solutions.

https://catalog.workshops.aws/cfn101/en-US/prerequisites/account

2) (Optional) Install and configure the AWS CLI version 2 

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

# Deployment


1) Create CloudFormation (CFN) stack using YAML solution templates.

Using AWS Console:

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-stack.html


Using AWS CLI:

```
aws cloudformation create-stack \
  --stack-name myteststack \
  --template-body file:///path-to-file/eksalbwaf.yaml
```

# Related AWS Services

| AWS Service  | Product Page |
| ------------- | ------------- |
| Amazon CloudFront| https://aws.amazon.com/cloudfront/ |
| AWS WAF | https://aws.amazon.com/waf/|
| Amazon CloudWatch| https://aws.amazon.com/cloudwatch/ |
| Amazon EKS  | https://aws.amazon.com/eks/ |



# Estimated Costs

The cost estimation for each service is presented below **(CAUTION: costs may vary considering your use case)**

- AWS Region: US East (N. Virginia)

- This AWS WAF configuration is estimated to cost $14 for 10 million requests/month

- This Amazon CloudFront configuration is estimated to cost $5.10 for 10,000,000 HTTPS requests

- This AWS WAF configuration is estimated to cost $26.00 for 10 million requests (per web ACL)

- Monthly cost: 93.63 USD

- Total 12 months cost: 1,123.56 USD



# Cleaning Up

Delete CloudFormation stack for resources termination/deletion.


