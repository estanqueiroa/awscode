####################################################################################################
# © 2025 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.                         #
#                                                                                                  #
# This AWS Content is provided subject to the terms of the AWS Customer Agreement                  #
# available at http://aws.amazon.com/agreement or other written agreement between                  #
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.          #
####################################################################################################

module "aws_budget" {
  source = "./modules/budget"

  budget_name       = var.budget_name
  limit_amount      = var.limit_amount      # "500"
  time_period_start = var.time_period_start # "2023-01-01_00:00"
  time_period_end   = var.time_period_end   # "2030-12-31_23:59"

  frequency       = var.frequency
  time_unit       = var.time_unit
  subscriber_type = var.subscriber_type


  email_address = var.email_address

  anomaly_percentage = var.anomaly_percentage
  anomaly_absolute   = var.anomaly_absolute

  global_tags = var.tags

}


