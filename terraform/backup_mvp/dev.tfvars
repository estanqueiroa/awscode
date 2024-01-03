resource_name = ["ec2", "rds", "s3"]
lifecycle_time = "14"
schedule = "cron(0 9 ? * 1 *)" # Every sunday at 9 AM
backup_tag_key = "Backup"
backup_tag_value = "true" # this value is appended with service prefix

