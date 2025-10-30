####################################################################################################
# © 2025 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.                         #
#                                                                                                  #
# This AWS Content is provided subject to the terms of the AWS Customer Agreement                  #
# available at http://aws.amazon.com/agreement or other written agreement between                  #
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.          #
####################################################################################################

aws_region = "us-east-1"

budget_name = "aws-monthly-budget"

limit_amount      = "500"
time_period_start = "2023-01-01_00:00"
time_period_end   = "2030-12-31_23:59"
time_unit         = "MONTHLY"

frequency       = "IMMEDIATE" # Immediate frequencies only support SNSTopic subscriptions
subscriber_type = "SNS"       # EMAIL

anomaly_percentage = 50  # percentage
anomaly_absolute   = 100 # USD

email_address = "johndoe@domain.com" # email address to receive notification alerts

tags = {
  app           = "cost-anomaly-detection"
  gerenciamento = "terraform-aft"
  projeto       = "landingzone-aws"
}
