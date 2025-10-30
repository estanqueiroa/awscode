

locals {
  sns_topic_arn = var.subscriber_type == "SNS" ? aws_sns_topic.cost_anomaly_updates[0].arn : null
  kms_key_arn   = var.subscriber_type == "SNS" ? aws_kms_key.sns_encryption[0].arn : null
}
