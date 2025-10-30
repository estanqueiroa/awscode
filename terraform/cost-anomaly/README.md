# AWS Budget Configuration

This module sets up AWS Budget alerts and Cost Anomaly Detection with customizable notification settings.

## Features

- Monthly budget monitoring
- Cost anomaly detection
- SNS or Email notifications
- Customizable threshold alerts
- KMS encryption for SNS topics

## Requirements

- Terraform >= 1.13.3
- AWS Provider
- AWS Account with appropriate permissions

## Usage

```hcl
module "aws_budget" {
  source = "./modules/budget"

  aws_region  = "sa-east-1"
  budget_name = "monthly-budget"

  # Budget Configuration
  limit_amount      = "500"
  time_period_start = "2023-01-01_00:00"
  time_period_end   = "2030-12-31_23:59"
  time_unit         = "MONTHLY"

  # Notification Configuration
  frequency       = "IMMEDIATE"  # Only supports SNS Topic subscriptions
  subscriber_type = "SNS"        # Options: SNS or EMAIL

  # Anomaly Detection Settings
  anomaly_percentage = 50   # Percentage threshold
  anomaly_absolute   = 100  # USD threshold

  # Email Configuration (when subscriber_type = EMAIL)
  email_address = "example@amazon.com"

  # Required Tags
  tags = {
    ambiente        = "prd"               # Required: prd, dev, hom
    centro_de_custo = "speg"             # Required
    empresa         = "banco_bradesco_sa" # Required
    app             = "cost-anomaly-detection"
    gerenciamento   = "terraform-aft"
    projeto         = "ativacao-aws"
  }
}
```

    
## Variables

* aws_region:	AWS Region	(string)
* budget_name:	Name for the budget	(string)
* limit_amount:	Budget limit in USD	(string)
* time_period_start:	Start time for budget (format: YYYY-MM-DD_HH:mm)	(string)
* time_period_end:	End time for budget (format: YYYY-MM-DD_HH:mm)	(string)
* time_unit:	Time unit for budget	(string)	yes	"MONTHLY"
* frequency:	Notification frequency	(string)	yes	"IMMEDIATE"
* subscriber_type:	Type of notification subscription	(string)
* anomaly_percentage:	Percentage threshold for anomaly detection	(number)
* anomaly_absolute:	Absolute threshold (USD) for anomaly detection	(number)
* email_address:	Email address for notifications	(string)	no	-
* tags:	Resource tags	map(string)

## Required Tags

The following tags are mandatory:

* ambiente: Environment (prd, dev, hom)
* centro_de_custo: Cost center
* empresa: Company name

## Deployment

Run Terraform commands below:

```
terraform init
terraform plan
terraform apply
```

## Outputs

* budget_id: ID of the created budget
* anomaly_detector_arn: ARN of Anomaly Detector
* sns_topic_arn: ARN of the SNS topic (only when subscriber_type = SNS)
* kms_key_arn: ARN of the KMS key (only when subscriber_type = SNS)

## Notifications

* SNS Topic: When subscriber_type = "SNS", an SNS topic is created with KMS encryption. Only supports `IMMEDIATE` frequency notifications

* Email: When subscriber_type = "EMAIL", direct email notifications are configured. Email address must be provided via `email_address` variable

## Security

* SNS topics are encrypted using KMS

* IAM policies follow least privilege principle

## Notes

* IMMEDIATE frequency only supports SNS Topic subscriptions
* Email notifications don't support IMMEDIATE frequency
* Time periods should be in format: YYYY-MM-DD_HH:mm
* All mandatory tags must be provided

