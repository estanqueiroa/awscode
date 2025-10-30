####################################################################################################
# © 2025 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.                         #
#                                                                                                  #
# This AWS Content is provided subject to the terms of the AWS Customer Agreement                  #
# available at http://aws.amazon.com/agreement or other written agreement between                  #
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.          #
####################################################################################################

locals {
  sns_topic_arn = var.subscriber_type == "SNS" ? aws_sns_topic.cost_anomaly_updates[0].arn : null
  kms_key_arn   = var.subscriber_type == "SNS" ? aws_kms_key.sns_encryption[0].arn : null
}
