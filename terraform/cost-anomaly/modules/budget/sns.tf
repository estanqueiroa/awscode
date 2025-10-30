####################################################################################################
# © 2025 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.                         #
#                                                                                                  #
# This AWS Content is provided subject to the terms of the AWS Customer Agreement                  #
# available at http://aws.amazon.com/agreement or other written agreement between                  #
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.          #
####################################################################################################

resource "aws_sns_topic" "cost_anomaly_updates" {

  count = var.subscriber_type == "SNS" ? 1 : 0

  name = "${var.budget_name}-cost-anomaly-updates"

  kms_master_key_id = local.kms_key_arn

  tags = var.global_tags
}


resource "aws_sns_topic_subscription" "cost_anomaly_updates" {

  count = var.subscriber_type == "SNS" ? 1 : 0

  topic_arn = local.sns_topic_arn
  protocol  = "email"
  endpoint  = var.email_address
}



data "aws_iam_policy_document" "sns_topic_policy" {

  count = var.subscriber_type == "SNS" ? 1 : 0

  policy_id = "__default_policy_ID"

  statement {
    sid = "AWSAnomalyDetectionSNSPublishingPermissions"

    actions = [
      "SNS:Publish"
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["costalerts.amazonaws.com"]
    }

    resources = [
      local.sns_topic_arn
    ]
  }

  statement {
    sid = "__default_statement_ID"

    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission"
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      local.sns_topic_arn
    ]
  }
}

resource "aws_sns_topic_policy" "default" {

  count = var.subscriber_type == "SNS" ? 1 : 0

  arn = local.sns_topic_arn

  policy = data.aws_iam_policy_document.sns_topic_policy[0].json
}

