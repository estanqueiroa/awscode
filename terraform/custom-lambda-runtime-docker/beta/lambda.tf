# https://awstip.com/advanced-aws-lambda-an-obscure-feature-you-must-absolutely-use-2d03110d563f


data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  current_account_number = data.aws_caller_identity.current.account_id
  region                 = data.aws_region.current.name
}

module "custom-lambda" {
  source                           = "github.com/Ilyassxx99/lambda-custom-runtime.git"
  custom_bash_function_name        = "custom-bash-function"
  custom_bash_ecr_repository_name  = "custom-lambda"
  current_account_number           = local.current_account_number
  docker_image_custom_bash_uri     = "custom-lambda:latest"
  lambda_image_custom_bash_version = "3.12.2"
  lambda_image_arch                = "amd64"
  region                           = local.region
  tags = {
    Terraform-module = "custom-bash-runtime"
  }
}
