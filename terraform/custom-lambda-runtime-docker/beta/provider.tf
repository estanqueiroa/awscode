# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.26"
    }
  }
}

provider "aws" {

  region = "us-east-1"

  default_tags {
    tags = {
      # mandatory tags
      # "Cost Center"  = var.cost_center
      # shared_costs   = var.shared_costs
      # Product        = var.product
      # APM_functional = var.apm_functional
      # CIA            = var.cia
      # custom tags
      entity            = "optional"
      environment       = "bnp-account"
      APM_technical     = "0001"
      business_service  = "0001"
      service_component = "aws-infra"
      description       = "migracionBNP"
      management_level  = "IaaS"
      #AutoStartStopSchedule = "08/18,08/18,08/18,08/18,08/18,-,-;0" #this format doesn´t work in AWS
      tracking_code = "CMDBtracking"

      # AWS tags

      # PVRE                    = "true"
      # Schedule                = var.tag_schedule
      # "${var.backup_tag_key}" = var.backup_tag_value
    }
  }

}