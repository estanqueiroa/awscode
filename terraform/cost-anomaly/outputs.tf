

output "budget_id" {
  description = "The ID of the Budget"
  value       = module.aws_budget.budget_id
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = module.aws_budget.sns_topic_arn
}

output "anomaly_detector_arn" {
  description = "The ARN of the Anomaly Detector"
  value       = module.aws_budget.anomaly_detector_arn
}


output "kms_key_arn" {
  value = module.aws_budget.kms_key_arn
}
