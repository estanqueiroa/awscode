# S3 + CloudFront + WAF + Shield Advanced (optional) Template

A CloudFormation template for deploying a secure static website hosting solution on AWS using S3, CloudFront, WAF, and Shield Advanced DDoS protection.

## Overview

This template provisions a complete static content delivery infrastructure with:
- **Amazon S3** for static content storage
- **CloudFront** distribution for global content delivery with origin access control (OAC)
- **AWS WAF** (Web Application Firewall) with managed rules and geoblocking
- **AWS Shield Advanced** for advanced DDoS protection (optional, requires subscription)

![Alt text](s3-cloudfront-waf-shield.png?raw=true "Diagram Image")

## Prerequisites

1. **AWS Account** with appropriate IAM permissions to create CloudFormation resources
2. **AWS Shield Advanced Subscription** (Optional - required for Shield Advanced protection)
   - Subscribe here: https://docs.aws.amazon.com/waf/latest/developerguide/enable-ddos-prem.html
   - Alternatively, use **AWS Firewall Manager** to simplify subscriptions: https://docs.aws.amazon.com/waf/latest/developerguide/getting-started-fms-shield.html
3. **ACM Certificate** for your custom domain
   - Certificate must be in the `us-east-1` region (CloudFront requirement)
4. **Custom Domain** registered and DNS configured - You will need access to create host records to validate SSL certificate configuration for your domain

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `pNameBucket` | String | `static-hosting-demo-estanqua` | S3 bucket name for static content |
| `pAlternateDomainName` | String | `*.yourdomain.com` | Custom domain name for CloudFront distribution |
| `pAcmCertificateId` | String | `id123456789012` | ACM Certificate ID (without `arn:` prefix) |
| `pOACName` | String | `static-hosting-OAC` | Origin Access Control name for S3 bucket |

## Deployment Instructions

### Step 1: Prepare Your Content

Create two HTML files for your static website:

**index.html**
```html
<!DOCTYPE html>
<html>
    <head>
        <title>My Static Site</title>
    </head>
    <body style="background-color: lightpink">
        <h1>Hello! This is my static hosting!</h1>
    </body>
</html>
```

**error.html** (for 404/403 errors)
```html
<!DOCTYPE html>
<html>
  <head>
    <title>Error</title>
  </head>
  <body>
    <h1>Oops, something went wrong!</h1>
    <p>We encountered an error while processing your request.</p>
  </body>
</html>
```

### Step 2: Get ACM Certificate ID

1. Go to AWS Certificate Manager (ACM) in `us-east-1` region
2. Find your certificate for your domain
3. Copy the **Certificate ID** (the UUID part, not the full ARN)

### Step 3: Deploy the Stack

```bash
aws cloudformation create-stack \
  --stack-name static-hosting \
  --template-body file://s3-cloudfront-waf-shield.yml \
  --parameters \
    ParameterKey=pNameBucket,ParameterValue=my-unique-bucket-name \
    ParameterKey=pAlternateDomainName,ParameterValue=www.yourdomain.com \
    ParameterKey=pAcmCertificateId,ParameterValue=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx \
    ParameterKey=pOACName,ParameterValue=static-hosting-OAC
```

### Step 4: Upload Content to S3

After stack creation completes:

```bash
aws s3 cp index.html s3://my-unique-bucket-name/
aws s3 cp error.html s3://my-unique-bucket-name/
```

### Step 5: Update DNS

Point your domain to CloudFront using a CNAME record:
- **Name:** `www.yourdomain.com`
- **Value:** CloudFront domain name (from stack outputs)

## Features

### Security

- **Origin Access Control (OAC)** - S3 bucket is private; only CloudFront can access it
- **AWS WAF Protection:**
  - AWSManagedRulesCommonRuleSet - Protection against common web exploits
  - AWSManagedRulesKnownBadInputsRuleSet - Blocks malformed requests
  - AWSManagedRulesAmazonIpReputationList - Blocks IPs with bad reputation
  - Geoblocking - Allows only specific countries (customizable)
  - Rate limiting - 100 requests per IP per 5 minutes

- **AWS Shield Advanced** (Optional) - DDoS protection with automatic response

### Performance

- **CloudFront Global CDN** - 200+ edge locations worldwide
- **HTTP/2** - Faster protocol
- **Gzip Compression** - Reduced transfer size
- **Optimized Caching** - CachingOptimizedForUncompressedObjects policy

### Error Handling

- 404 errors redirect to `error.html` with 200 status
- 403 errors redirect to `error.html` with 200 status

## Customization

### Enable WAF Logging (Optional)

Uncomment the logging sections in the template and specify a CloudWatch log group for WAF activity logs.

### Enable Shield Advanced Protection (Optional)

Uncomment the `rProtection` resource and ensure Shield Advanced is subscribed:

```yaml
rProtection:
  Type: AWS::Shield::Protection
  Properties:
    Name: 'MyDistributionwithL7Protection'
    ResourceArn: !Sub "arn:aws:cloudfront::${AWS::AccountId}:distribution/${rCloudFrontDistribution}"
    ApplicationLayerAutomaticResponseConfiguration:
      Status: ENABLED
      Action:
        Block: { }
```

### Modify Geoblocking Countries

Edit the `GeoMatch` rule countries list:

```yaml
CountryCodes:
  - ES
  - GB
  - US
  # Add/remove country codes as needed
```

### Adjust Rate Limiting

Change the `Limit` value in `LimitRequests100` rule (current: 100 requests per 5 minutes).

## Stack Outputs

| Output | Description |
|--------|-------------|
| `S3BucketName` | Name of the S3 bucket |
| `OriginAccessControl` | OAC ID for S3 access |
| `CloudFrontDist` | CloudFront distribution ID |
| `CloudFrontDomain` | CloudFront domain name (use for DNS CNAME) |

## Troubleshooting

### Error: "The subscription does not exist"

Shield Advanced is not subscribed. Enable the subscription before deploying the protection resource.

### Error: "Certificate not found"

Ensure your ACM certificate exists in `us-east-1` and you've copied the correct certificate ID.

### S3 Access Denied

Verify the bucket policy is attached and OAC is properly configured. The S3 bucket must be private.

### CloudFront returns 404 errors

Ensure `index.html` and `error.html` are uploaded to the S3 bucket root directory.

## References

- [Original Template](https://blog.canopas.com/deploy-a-website-with-aws-s3-cloudfront-using-cloudformation-c2199dc6c435)
- [AWS Shield Advanced Examples](https://github.com/aws-samples/aws-shield-advanced-examples)
- [AWS Shield Protection CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-shield-protection.html)
- [CloudFront Cache Policies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html)

## License

© Amazon.com and Affiliates. This deliverable is considered Developed Content as defined in the AWS Service Terms.

## Support

For issues or questions:
1. Check CloudFormation events in AWS Console
2. Verify all prerequisites are met