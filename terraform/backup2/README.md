## AWS Backup

AWS Backup service simplifies the backup process by allowing users to apply plans to AWS resources by tagging and automating the backup process based on the defined plan.

Solution based on this blog: https://medium.com/israeli-tech-radar/what-is-an-aws-backup-and-how-to-automate-it-3bdf8b1df9eb

Backup selection is based on tag key/value. The tag value indicates corresponding Backup vault for each service. E.g. tag value "rds-true" indicates RDS Backup vault.

![Alt text](../diagrams/backup.png?raw=true "Diagram Image")


## AWS Backup Supported Resources

The most popular supported AWS resources:

* Amazon Elastic Compute Cloud (Amazon EC2)

* Amazon Simple Storage Service (Amazon S3)

* Amazon Relational Database Service (Amazon RDS)

* Amazon Elastic File System (Amazon EFS)

* Amazon Elastic Block Store (Amazon EBS)

* Amazon DynamoDB

Full list here: https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#features-by-resource

## Deploy

Go to Linux terminal to run locally.

Set environment variables:

```bash
export AWS_ACCESS_KEY_ID="A1b2C3d4E5"
export AWS_SECRET_ACCESS_KEY="A1b2C3d4E5"
export AWS_DEFAULT_REGION="us-east-1"
```

Go to the project directory:

```bash
cd backup
```


Edit dev.tfvars variables file with your backup information:

```json
resource_name = ["ec2", "rds", "s3"]
lifecycle_time = "14"
schedule = "cron(0 9 ? * 1 *)" # Every sunday at 9 AM
backup_tag_key = "Backup"
backup_tag_value = "true" # this value is appended with service prefix
```

Terraform workflow:

```bash
terraform init
terraform validate
terraform plan --var-file=dev.tfvars
terraform apply --var-file=dev.tfvars --auto-approve
```



## References

https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html

https://docs.aws.amazon.com/aws-backup/latest/devguide/API_BackupSelection.html
