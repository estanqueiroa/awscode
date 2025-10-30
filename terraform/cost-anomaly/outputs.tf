####################################################################################################
# © 2025 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.                         #
#                                                                                                  #
# This AWS Content is provided subject to the terms of the AWS Customer Agreement                  #
# available at http://aws.amazon.com/agreement or other written agreement between                  #
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.          #
####################################################################################################

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
