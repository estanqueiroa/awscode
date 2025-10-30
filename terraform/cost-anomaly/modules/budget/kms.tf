####################################################################################################
# © 2025 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.                         #
#                                                                                                  #
# This AWS Content is provided subject to the terms of the AWS Customer Agreement                  #
# available at http://aws.amazon.com/agreement or other written agreement between                  #
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.          #
####################################################################################################

resource "aws_kms_key" "sns_encryption" {

  count = var.subscriber_type == "SNS" ? 1 : 0

  description         = "KMS key for SNS topic ${var.budget_name} encryption"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.cmk_policy[0].json

  tags = var.global_tags


}

# Create KMS alias
resource "aws_kms_alias" "sns_key_alias" {

  count = var.subscriber_type == "SNS" ? 1 : 0

  name          = "alias/${var.budget_name}-cost-anomaly-updates"
  target_key_id = aws_kms_key.sns_encryption[0].key_id
}

data "aws_iam_policy_document" "cmk_policy" {
  #checkov:skip=CKV_AWS_111:This is KMS resource policy and hence using '*' for resources
  #checkov:skip=CKV_AWS_109:This is KMS resource policy and hence using '*' for resources
  #checkov:skip=CKV_AWS_356:This is KMS resource policy and hence using '*' for resources

  count = var.subscriber_type == "SNS" ? 1 : 0

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid = "Allow access for Key Administrators"
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]
    resources = ["*"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AWSControlTowerExecution",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AWSAFTExecution"
      ]
    }
  }
  statement {
    sid    = "Allow SNS service to use the key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:ReEncrypt",
      "kms:Describe*"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:EncryptionContext:aws:sns:topicArn"
      values   = ["arn:aws:sns:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:${var.budget_name}-cost-anomaly-updates"]
    }
  }

}


