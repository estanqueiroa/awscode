####################################################################################################
# © 2025 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.                         #
#                                                                                                  #
# This AWS Content is provided subject to the terms of the AWS Customer Agreement                  #
# available at http://aws.amazon.com/agreement or other written agreement between                  #
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.          #
####################################################################################################

output "sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = var.subscriber_type == "SNS" ? local.sns_topic_arn : null
}

output "budget_id" {
  description = "The ID of the BUDGET"
  value       = aws_budgets_budget.total_cost.id
}

output "anomaly_detector_arn" {
  description = "The ARN of the ANOMALY DETECTOR"
  value       = aws_ce_anomaly_monitor.service_monitor.arn
}


output "kms_key_arn" {
  description = "The ARN of the KMS key"
  value       = var.subscriber_type == "SNS" ? local.kms_key_arn : null
}

